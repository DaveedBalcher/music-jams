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
                
                if (venueItem.filterValues.contains { $0.key == filter.type }),
                   let filterParam = venueItem.filterValues[filter.type],
                   filterParam.filter(filter.values.contains).count > 0 {
                    // Should include venue
                } else {
                    return false
                }
            }
            return true
        }
    }
}

public struct FilterParameter: Equatable {
    let type: FilterType
    let values: [String]
    
    public init(type: FilterType, values: [String]) {
        self.type = type
        self.values = values
    }
    
    public static func == (lhs: FilterParameter, rhs: FilterParameter) -> Bool {
        lhs.type == rhs.type
    }
}
