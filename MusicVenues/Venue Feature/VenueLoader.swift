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
    
    func retrieveFiltered(filters: [FilterParameter]? = nil) -> (venues: [VenueItem], neighborhoods: [NeighborhoodItem], filterOptions: FilterOptions) {
        let loadedVenues = retrieveVenues()
        
        let filters = filters ?? [
            FilterParameter(type: .genres, values: Set(loadedVenues.getGenreOptions())),
            FilterParameter(type: .vibes, values: Set(loadedVenues.getVibeOptions()))
        ]
        
        let filteredVenues = FilterProcesser.filter(loadedVenues, with: filters)
        let filteredNeighborhoods = filteredVenues.neighborhoods
        let filteredGenres = filteredVenues.getGenreOptions()
        let filteredVibes = filteredVenues.getVibeOptions()
        
        return (filteredVenues, filteredNeighborhoods, FilterOptions(genreOptions: filteredGenres, vibeOptions: filteredVibes))
    }
}
