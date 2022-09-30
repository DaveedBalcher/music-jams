//
//  SectionModel.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 9/16/22.
//

import Foundation
import MusicVenues

struct SectionModel: Comparable {
    let type: String
    let displayIndex: Int
    let options: [String]
    var selectedOption: String?
    
    static func < (lhs: SectionModel, rhs: SectionModel) -> Bool {
        lhs.displayIndex > rhs.displayIndex
    }
}

extension SectionModel {
    static func mapFromFilters(filterOptions: [String : [String]], filterSelected: [String: String?]) -> [SectionModel] {
        
        filterOptions.map { filter in
            SectionModel(type: filter.key,
                         displayIndex: [VibeType.description, GenreType.description].firstIndex(of: filter.key) ?? 0,
                         options: filter.value.filter { $0 != VibeType.defaultValue.rawValue},
                         selectedOption: filterSelected[filter.key] ?? nil
            )
        }
            .sorted()
    }
}
