//
//  Bundle+Extension.swift
//  AppStoreCompositionalLayout
//
//  Created by Alfian Losari on 11/9/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import Foundation

fileprivate let jsonDecoder = JSONDecoder()

extension Bundle {
    
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D {
        guard let url = url(forResource: filename, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "JSON file not found"])
        }
        return try jsonDecoder.decode(D.self, from: data)
    }
    
}
