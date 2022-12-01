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
        title = event.title
        
        let formatter = RelativeDateTimeFormatter()
        if let nextDate = event.nextDate {
            date = formatter.localizedString(for: nextDate, relativeTo: Date())
        } else {
            date = "N/A"
        }
        hosts = event.hosts.joined(separator: ", ")
        url = event.url
    }
}
