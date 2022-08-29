//
//  MapLoader.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/4/22.
//

import Foundation

public protocol VenueLoader {
    
    typealias FilterOptions = (genreOptions: [String], vibeOptions: [String])
    
    func retrieveVenues() -> [VenueItem]
    func retrieveFilters() -> FilterOptions
}

public extension VenueLoader {
    
    func retrieveFiltered(filters: [FilterParameter]? = nil) -> (venues: [VenueItem], neighborhoods: [NeighborhoodItem], genreOptions: [GenreType], vibeOptions: [VibeType]) {
        let loadedVenues = retrieveVenues()
        
        let filters = filters ?? [
            FilterParameter(type: .genres, values: loadedVenues.getGenres().rawValues),
            FilterParameter(type: .vibes, values: loadedVenues.getVibes().rawValues)
        ]
        
        let filteredVenues = FilterProcesser.filter(loadedVenues, with: filters)
        let filteredNeighborhoods = filteredVenues.neighborhoods
        let filteredGenres = filteredVenues.getGenres()
        let filteredVibes = filteredVenues.getVibes()
        return (filteredVenues, filteredNeighborhoods, filteredGenres, filteredVibes)
    }
}
