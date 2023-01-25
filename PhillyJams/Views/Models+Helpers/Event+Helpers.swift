//
//  Event+Helpers.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 11/22/22.
//

import Foundation
import MusicVenues

extension Event {
    var nextDate: Date? {
        dates.first
    }
    
    var hostsString: String {
        hosts.joined(separator: ", ")
    }
}
