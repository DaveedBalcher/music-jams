//
//  FilterProcessor.swift
//  MusicVenues
//
//  Created by Daveed Balcher on 8/21/22.
//

import Foundation

public struct FilterProcesser {
    
    public static func filter(_ venues: [VenueItem], with filters: [FilterParameter]) -> [VenueItem] {
        if filters.isEmpty { return venues }
        
        return venues.filter { venueItem in
            
            for filter in filters {
                
                if filter.allSelected || check(venue: venueItem, for: filter) {
                    // Should include venue
                } else {
                    return false
                }
            }
            return true
        }
    }
    
    private static func check(venue venueItem: VenueItem, for filter: FilterParameter) -> Bool {
        if (venueItem.filterValues.contains { $0.key == filter.type }),
           let filterParam = venueItem.filterValues[filter.type],
           filterParam.filter(filter.values.contains).count > 0 {
            return true
        } else {
            return false
        }
    }
}

public struct FilterParameter: Equatable {
    let type: FilterType
    let values: Set<String>
    let allSelected: Bool
    
    public init(type: FilterType, values: Set<String>, allSelected: Bool = true) {
        self.type = type
        self.values = values
        self.allSelected = allSelected
    }
    
    public static func == (lhs: FilterParameter, rhs: FilterParameter) -> Bool {
        lhs.type == rhs.type
    }
}
