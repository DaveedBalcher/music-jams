//
//  DefaultPlaceMapper.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/5/22.
//

import Foundation

extension DefaultPlaceMapper {
    
    struct Root: Decodable {
        let levelOneRegions: [DefaultRegion]
        let places: [DefaultPlace]
        
        var regionItems: [Region] {
            levelOneRegions.map { $0.item }
        }
        
        var placeItems: [Place] {
            places.map {
                $0.getItem { string in
                    regionItems.first { $0.title == string }!
                }
            }
        }
    }
}
