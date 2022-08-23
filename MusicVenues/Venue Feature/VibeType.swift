//
//  VibeType.swift
//  MusicVenues
//
//  Created by Daveed Balcher on 8/22/22.
//

import Foundation

public enum VibeType: String, CaseIterable, Identifiable {
    
    public var id: Int {
        self.hashValue
    }
    
    case vibe1 = "Loose",
        vibe2 = "Chill",
        vibe3 = "Moderate",
        vibe4 = "Serious",
        vibe5 = "Whiplash"
    
    
    public static var description: String {
        "Vibes"
    }
}

public extension Collection where Element == VibeType {
    var rawValues: [String] {
        self.map { $0.rawValue }
    }
}

