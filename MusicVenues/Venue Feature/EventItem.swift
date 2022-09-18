//
//  EventItem.swift
//  MusicVenues
//
//  Created by Daveed Balcher on 9/18/22.
//

import Foundation

public struct EventItem: Identifiable {
    public let id: UUID
    public let name: String
    public let type: String
    public let dayOfTheWeek: String
    public let startTime: String
    public let endTime: String
    public let vibeIndex: Int?
    public let genres: [String]?
    public let hosts: [String]?
    public let url: String?
}
