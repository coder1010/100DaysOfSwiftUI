//
//  Webservice.swift
//  FilteringData
//
//  Created by Chhaya on 4/3/22.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case invalidRequest
}

class Webservice {
    
    func getAllUniversities(url : URL) async throws -> [University] {
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidRequest
        }
        
        let unis = try? JSONDecoder().decode([University].self, from: data)
        print("Unis here::\(data)")
        return unis ?? []
    }
}
