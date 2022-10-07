//
//  EventItem.swift
//  MusicVenues
//
//  Created by Daveed Balcher on 9/18/22.
//

import Foundation

public struct EventItem: Identifiable, Comparable {
    public let id: UUID
    public let name: String
    public let type: String
    public let dayOfTheWeek: String
    public let dayOfTheWeekIndex: Int
    public let startTime: String
    public let endTime: String
    public let vibeIndex: Int?
    public let genres: [String]?
    public let hosts: [String]?
    public let url: String?
    
    public static func < (lhs: EventItem, rhs: EventItem) -> Bool {
        lhs.dayOfTheWeekIndex < rhs.dayOfTheWeekIndex
    }
}
