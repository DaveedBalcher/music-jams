//
//  VibeType.swift
//  MusicPlaces
//
//  Created by Daveed Balcher on 8/22/22.
//

import Foundation

public enum VibeType: String, CaseIterable, Identifiable {
    
    public var id: Int {
        self.hashValue
    }
    
    case vibe1 = "Beginner-Friendly",
        vibe2 = "Chill",
        vibe3 = "Moderate",
        vibe4 = "Tight",
        vibe5 = "Whiplash",
        defaultValue = "Unspecified"
    
    public static var description: String {
        "Vibes"
    }
    
    public static func getVibe(from index: Int?) -> VibeType {
        switch index {
        case 0:
            return .vibe1
        case 1:
            return .vibe2
        case 2:
            return .vibe3
        case 3:
            return .vibe4
        case 4:
            return .vibe5
        default:
            return .defaultValue
        }
    }
}
