//
//  EventViewModel.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 11/15/22.
//

import Foundation
import MusicVenues

struct EventViewModel: Hashable {
    let title: String
    let date: String
    let hosts: String
    let url: URL?
    
    init(_ event: Event) {
        title = !event.title.isEmpty ? event.title : event.properties.dictonary["types"]?.first?.capitalized ?? ""
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, h:mm a"
        if let nextDate = event.nextDate {
            date = formatter.string(for: nextDate) ?? "N/A"
        } else {
            date = "N/A"
        }
        hosts = event.hosts.joined(separator: ", ")
        url = event.url
    }
}
