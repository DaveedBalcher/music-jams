//
//  MapLoader.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/4/22.
//

import Foundation

public protocol VenueLoader {
    
    typealias LoadCompletion = ([VenueItem]) -> Void
    typealias FilteredCompletion = (_ venueItems: [VenueItem], _ neighborhoodItems: [NeighborhoodItem], _ genreOptions: [GenreType], _ vibeOptions: [VibeType]) -> Void
    
    func load(completion: @escaping LoadCompletion)
}

public extension VenueLoader {
    
    func retrieveFiltered(filters: [String: String?]? = nil, completion: @escaping FilteredCompletion) {
        load { loadedVenues in

            let filteredVenues = loadedVenues 
            let filteredNeighborhoods = filteredVenues.neighborhoods
            let filteredGenres = filteredVenues.getGenres()
            let filteredVibes = filteredVenues.getVibes()
            
            completion(filteredVenues, filteredNeighborhoods, filteredGenres, filteredVibes)
        }
    }
}
