//
//  Model + Helpers.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 11/22/22.
//

import Foundation
import MusicVenues

extension Property {
    var valuesString: String {
        values.isEmpty ? "Unspecified" : values.joined(separator: ", ")
    }
}
