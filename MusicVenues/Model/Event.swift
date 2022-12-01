//
//  Event.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 11/14/22.
//

import Foundation

public struct Event {
    public let title: String
    public let description: String
    public let hosts: [String]
    public let dates: [Date]
    public let durationInMinutes: Int
    public let properties: [Property]
    public let url: URL?
    
    public init(title: String, description: String, hosts: [String], dates: [Date], duration: Int, properties: [Property], url: URL? = nil) {
        self.title = title
        self.description = description
        self.hosts = hosts
        self.dates = dates
        self.durationInMinutes = duration
        self.properties = properties
        self.url = url
    }
}
