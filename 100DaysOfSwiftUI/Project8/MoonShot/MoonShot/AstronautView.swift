//
//  AstronautView.swift
//  MoonShot
//
//  Created by Chhaya Ahuja on 5/11/21.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astraonaut
    struct MissionFlew {
        var id: String
        var role: String
        
        
        
    }
    var missionsFlown = [String]()
    var flown = [MissionFlew]()
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    //ForEach(self.missionsFlown, id: \.self) { name in
                    ForEach(self.flown, id: \.id) { flew in
                            HStack {
                                Image(flew.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.primary, lineWidth: 1))
                                VStack(alignment: .leading) {
                                    Text(flew.role)
                                        .font(.title3)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        
                    }
                    
                    
                }
                
            }
            
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    
    init(astronaut: Astraonaut) {
            self.astronaut = astronaut
        
        var flew = [MissionFlew]()
            let missions: [Missions] = Bundle.main.decode("missions.json")

            for mission in missions {
                for _ in mission.crew {
                    if let match = mission.crew.first(where: {$0.name == astronaut.id}) {
                        flew.append(MissionFlew(id: mission.image, role: "Apollo \(mission.id) - \(match.role)"))
                        break
                    }
                }
            }
        self.flown = flew
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astraonaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
