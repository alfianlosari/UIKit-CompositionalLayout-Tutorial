//
//  Item+Stubs.swift
//  AppStoreCompositionalLayout
//
//  Created by Alfian Losari on 11/9/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import Foundation

extension Item {
    
    static var storiesCarouselItems: [Item] {
        loadStubs(filename: "grid_carousel_items")
    }

    static var bannerCarouselItems: [Item] {
        loadStubs(filename: "banner_carousel_items")
    }
    
    static var columnItems: [Item] {
        loadStubs(filename: "sub_items")
    }
    
    static var listItems: [Item] {
        loadStubs(filename: "basic_items")
    }
    
    static var gridItems: [Item] {
        loadStubs(filename: "grid_items")
    }
    
    fileprivate static func loadStubs(filename: String) -> [Self] {
        do {
            let stubs: [Item] = try Bundle.main.loadAndDecodeJSON(filename: filename)
            return stubs
        } catch {
            print(error.localizedDescription)
            return []
        }
        
    }
    
}
