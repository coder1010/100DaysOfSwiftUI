//
//  ContentView.swift
//  FilteringData
//
//  Created by Chhaya on 4/3/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = UniversityListViewModel()
    var body: some View {
        UniversityListView(universities: vm.universities)
            .task {
                await vm.populateUniversities()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
