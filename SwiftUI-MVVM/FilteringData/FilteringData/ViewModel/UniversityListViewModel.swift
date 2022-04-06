//
//  UniversityListViewModel.swift
//  FilteringData
//
//  Created by Chhaya on 4/4/22.
//

import Foundation

class UniversityListViewModel : ObservableObject {
    @Published var universities: [UniversityViewModel] = []
    
    func populateUniversities() async {
        do{
            let universities = try await Webservice().getAllUniversities(url: Constants.URLs.allUniversitites)
            DispatchQueue.main.async {
                self.universities = universities.map(UniversityViewModel.init)
            }
        }
        catch {
            print(error)
        }
    }
}

struct UniversityViewModel {
    private let university: University
    init(university: University) {
        self.university = university
    }
    
    var country: String {
        university.country
    }
    var name: String {
        university.name
    }
    var alpha_two_code: String {
        university.alpha_two_code
    }
    
    var web_pages: [String] {
        university.web_pages
    }
    
    var domains: [String] {
        university.domains
    }
    
}
