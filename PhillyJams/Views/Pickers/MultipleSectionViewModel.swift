//
//  FilterPickersView.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 9/13/22.
//

import Foundation

class MultipleSectionViewModel: ObservableObject {
    @Published var sections: [SectionViewModel]
    
    var selectedOptions: [String : [String]] {
        sections.reduce(into: [String : [String]]()) { $0[$1.type] = $1.selectedOptions }
    }

    init(sections: [SectionViewModel]) {
        self.sections = sections
    }
}
