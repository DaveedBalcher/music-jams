//
//  MapLoader.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/4/22.
//

import Foundation

public protocol VenueLoader {
    func load()
    func retrieve() -> (venues: [VenueItem], neighborhoods: [NeighborhoodItem])
}

public extension VenueLoader {
    
    func retrieveFiltered(filters: [FilterParameter]) -> (venues: [VenueItem], neighborhoods: [NeighborhoodItem]) {
        let (loadedVenues, loadedNeighborhoods) = retrieve()
        
        let filteredVenues = FilterProcesser.filter(loadedVenues, with: filters)
        return (filteredVenues, loadedNeighborhoods)
    }
}
