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
        vibe5 = "Whiplash",
        defaultValue = "Unspecified"
    
    public static var description: String {
        "Vibes"
    }
}

extension VibeType: Comparable {
    public static func < (lhs: VibeType, rhs: VibeType) -> Bool {
        let lIndex = VibeType.allCases.firstIndex(of: lhs) ?? 0
        let rIndex = VibeType.allCases.firstIndex(of: rhs) ?? 0
        return lIndex < rIndex
    }
}

public extension Collection where Element == VibeType {
    var rawValues: [String] {
        self.map { $0.rawValue }
    }
}

