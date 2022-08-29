//
//  GenreType.swift
//  MusicVenues
//
//  Created by Daveed Balcher on 8/22/22.
//

import Foundation

public struct GenreType: Identifiable {
    
    public var id: Int {
        name.hashValue
    }
    public let name: String

    public var rawValue: String {
        name
    }
    
    public static var defaultValue: GenreType {
        GenreType(name: "Unspecified")
    }
    
    public static var description: String {
        "Genres"
    }
    
    public init(name: String) {
        self.name = name
    }
}

extension GenreType: Hashable, Comparable {
    public static func < (lhs: GenreType, rhs: GenreType) -> Bool {
        lhs.name < rhs.name
    }
}

public extension Collection where Element == GenreType {
    var rawValues: [String] {
        self.map { $0.rawValue }
    }
}

