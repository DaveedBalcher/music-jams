//
//  MapLoader.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/4/22.
//

import Foundation

public protocol VenueLoader {
    typealias LoadCompletion = ([VenueItem]) -> Void
    
    func load(completion: @escaping LoadCompletion)
}

public extension VenueLoader {
    
    func retrieveFilters(for venues: [VenueItem]) -> [String: [String]] {
        return [
            FilterType.vibes.rawValue : venues.getVibeOptions(),
            FilterType.genres.rawValue : venues.getGenreOptions()
        ]
    }
}
