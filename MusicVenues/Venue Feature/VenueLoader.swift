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
    
    func retrieveVenueData() -> (venues: [VenueItem], neighborhoods: [NeighborhoodItem], genreOptions: [GenreType], vibeOptions: [VibeType]) {
        let loadedVenues = retrieveVenues()
        let loadedNeighborhoods = loadedVenues.neighborhoods
        let loadedGenres = loadedVenues.getGenres()
        let loadedVibes = loadedVenues.getVibes()
        return (loadedVenues, loadedNeighborhoods, loadedGenres, loadedVibes)
    }
}
