//
//  ContentView.swift
//  MoonShot
//
//  Created by iChaya2.0 on 5/8/21.
//

import SwiftUI

struct ContentView: View {
    @State var astronautList = [Astraonaut]()
    @State var missionList = [Missions]()
    @State var showDate: Bool = false
    @State private var searchText = ""
    
    func getFullName(forName: String, astronauts: [Astraonaut]) -> String{
        var foundName : String = ""
        for _ in astronauts {
            if let match = astronauts.first(where: { $0.id == forName }) {
                foundName = match.name
            } else {
                fatalError("Missing")
            }
        }
        return foundName
    }
    
    var searchResults: [Missions] {
        if searchText.isEmpty {
            return missionList
        }
        else {
            return missionList.filter {$0.displayName.contains(searchText)}
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchResults) { mission in
                   // NavigationLink(destination: MissionView(mission: mission, astronauts: astronautList)) {
                        HStack {
                            ZStack {
                            Image(mission.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 44, height: 44)
                                Text("A\(mission.id)")
                                    .font(.caption)
                                    .background(.ultraThickMaterial)
                                    .foregroundColor(.indigo)

                            }
                            VStack(alignment: .leading) {
                                Text("***\(mission.displayName)***")
                                
                                    .font(.headline)
                                if (self.showDate) {
                                    Text("~~\(mission.formattedLaunchDate)~~")
                                }
                                else {
                                    ForEach(mission.crew, id: \.role) { crew in
                                        Text("`\(getFullName(forName: crew.name, astronauts: astronautList))`")
                                            .font(.footnote)
                                    }
                                }
                            }
                            
                        }
                        .swipeActions(allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                print("Hello")
                            }label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                            
                            Button {
                                print("Hello")
                            }label: {
                                Label("Archive", systemImage: "archivebox.fill")
                            }
                            .tint(.indigo)
                            
                        }
                   // }
                }
            }
            .refreshable
            {
                self.astronautList = Bundle.main.decode("astronauts.json")
                self.missionList = Bundle.main.decode("missions.json")
            }
            .searchable(text: $searchText)
            .listStyle(.sidebar)
            .navigationBarTitle("Moonshot")
            .navigationBarItems(leading: Button(self.showDate ? "Show Crew" : "Show Date"){
                showDate.toggle()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
