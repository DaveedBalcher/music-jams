//
//  FilterProcessor.swift
//  MusicVenues
//
//  Created by Daveed Balcher on 8/21/22.
//

import Foundation

public struct FilterProcesser {
    
    public static func filter(_ venues: [VenueItem], with filters: [String: String?]) -> [VenueItem] {
        if filters.isEmpty { return venues }
        
        return venues.filter { venueItem in
            
            for filter in filters {

                let type = filter.key
                
                if let filterParam = venueItem.filterValues.filter({ $0.key == type }).first,
                   (filter.value == nil || filterParam.value.contains(filter.value!)) {
                    // Should include venue
                } else {
                    return false
                }
            }
            return true
        }
    }
    
    public static func retrieveFilters(for venues: [VenueItem]) -> [String: [String]] {
        return [
            FilterType.eventType.rawValue : venues.getEventTypeOptions(),
            FilterType.vibes.rawValue : venues.getVibeOptions(),
            FilterType.genres.rawValue : venues.getGenreOptions()
        ]
    }
}
