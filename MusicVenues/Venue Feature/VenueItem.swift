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
    
    public init(id: UUID, name: String, imageURL: URL?, coordinates: Coordinates, neighborhood: NeighborhoodItem?, genres: [GenreType], vibe: VibeType) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.coordinates = coordinates
        self.neighborhood = neighborhood
        self.genres = genres
        self.vibe = vibe
    }
    
    public init(name: String, genres: [GenreType], vibe: VibeType) {
        self.id = UUID()
        self.name = name
        self.imageURL = nil
        self.coordinates = Coordinates.defaultValue
        self.neighborhood = nil
        self.genres = genres
        self.vibe = vibe
    }
}

public extension VenueItem {
    static var defaultItem: VenueItem {
        VenueItem(id: UUID(),
                  name: "Venue",
                  imageURL: nil,
                  coordinates: Coordinates.defaultValue,
                  neighborhood: nil,
                  genres: [],
                  vibe: .vibe3)
    }
    
    var genresDescription: String {
        (genres.map { $0.name}).joined(separator: ", ")
    }
}

public enum FilterType: String {
    case genres, vibes
}

public extension Collection where Element == VenueItem {
    var neighborhoods: [NeighborhoodItem] {
        Set(self.compactMap { $0.neighborhood }).sorted()
    }

    func getGenres() -> [GenreType] {
        Set(self.flatMap { $0.genres }).sorted()
    }
    
    func getVibes() -> [VibeType] {
        Set(self.compactMap { $0.vibe }).sorted()
    }
    
    func getGenreOptions() -> [String] {
        Set(self.flatMap { $0.genres.rawValues }).sorted()
    }
    
    func getVibeOptions() -> [String] {
        Set(self.compactMap { $0.vibe.rawValue }).sorted()
    }
}
