//
//  Bundle-Decodable.swift
//  MoonShot
//
//  Created by Chhaya Ahuja on 5/8/21.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        
        //1. Load json url
        
        guard let url = self.url(forResource: file, withExtension: nil) else{
            fatalError("Failed to locate \(file) in bundle")
        }
        
        //2. Get data from url
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle")
        }
        
        let decoder = JSONDecoder()
        
        //4. Format Date
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-DD"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        //3. Decode data & return that
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle")
        }
        return loaded
    }
}
