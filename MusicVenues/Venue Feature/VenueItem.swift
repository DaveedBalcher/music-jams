//
//  VenueItem.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/4/22.
//

import Foundation

public struct VenueItem: Identifiable, Equatable {
    public let id: UUID
    public let name: String
    public let imageURL: URL?
    public let coordinates: Coordinates
    public let neighborhood: NeighborhoodItem?
    public let genres: [GenreType]
    public let vibe: VibeType
    public var filterValues: [FilterType: [String]] {
        [
            .genres : genres.map { $0.rawValue },
            .vibes : [vibe.rawValue]
        ]
    }
    
    public static func == (lhs: VenueItem, rhs: VenueItem) -> Bool {
        lhs.name == rhs.name
    }
}

public enum FilterType: String {
    case genres, vibes
}

public extension Collection where Element == VenueItem {
    var genres: [GenreType] {
        Set(self.flatMap { $0.genres }).sorted()
    }
}
