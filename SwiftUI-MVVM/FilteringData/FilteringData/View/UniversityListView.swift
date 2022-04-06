//
//  UniversityListView.swift
//  FilteringData
//
//  Created by Chhaya on 4/5/22.
//

import SwiftUI

struct UniversityListView: View {
    let universities: [UniversityViewModel]
    
    var body: some View {
        //List(universities, id: \.name){ uni in
        List {
            ForEach(universities, id: \.name){ uni in
                UniversityCellView(university:uni)
            }
        }
    }
}

struct UniversityListView_Previews: PreviewProvider {
    static var previews: some View {
        UniversityListView(universities: [])
    }
}
