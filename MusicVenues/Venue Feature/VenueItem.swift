//
//  VenueItem.swift
//  MusicVenues
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
    public let events: [EventItem]
//    public let vibe: VibeType
    public var filterValues: [String: [String]] {
        [
            FilterType.genres.rawValue : genres,
            FilterType.vibes.rawValue : [vibe]
        ]
    }
    
    public static func == (lhs: VenueItem, rhs: VenueItem) -> Bool {
        lhs.name == rhs.name
    }
    
    public init(id: UUID, name: String, imageURL: URL?, coordinates: Coordinates, neighborhood: NeighborhoodItem?, events: [EventItem]) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.coordinates = coordinates
        self.neighborhood = neighborhood
        self.events = events
    }
    
//    public init(name: String, genres: [GenreType], vibe: VibeType) {
//        self.id = UUID()
//        self.name = name
//        self.imageURL = nil
//        self.coordinates = Coordinates.defaultValue
//        self.neighborhood = nil
//        self.events = []
//        self.vibe = vibe
//    }
}

public extension VenueItem {
    static var defaultItem: VenueItem {
        VenueItem(id: UUID(),
                  name: "Venue",
                  imageURL: nil,
                  coordinates: Coordinates.defaultValue,
                  neighborhood: nil,
                  events: [])
    }
    
    var vibe: String {
        events.compactMap { VibeType.getVibe(from: $0.vibeIndex).rawValue }.first ?? VibeType.defaultValue.rawValue
    }
    
    var genres: [String] {
        events.compactMap { $0.genres }.flatMap { $0 }
    }
    
    var genresDescription: String {
        (genres.map { $0 }).joined(separator: ", ")
    }
}

public enum FilterType: String {
    case genres, vibes
}

public extension Collection where Element == VenueItem {
    var neighborhoods: [NeighborhoodItem] {
        Set(self.compactMap { $0.neighborhood }).sorted()
    }
    
    func getGenreOptions() -> [String] {
        Set(self.flatMap { $0.genres }).sorted()
    }
    
    func getVibeOptions() -> [String] {
        Set(self.compactMap { $0.vibe }).sorted()
    }
}
