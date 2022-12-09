//
//  FilterPickersView.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 9/13/22.
//

import Foundation

final class SectionViewModel: ObservableObject {
    let type: String
    let options: [String]
    @Published var selectedOptions: [String] = []
    
    init(type: String, options: [String], selectedOption: [String] = []) {
        self.type = type
        self.options = options
        self.selectedOptions = selectedOption
    }
    
    func didToggleSelectAll() {
        if selectedOptions.count <= 1 {
            selectedOptions = options
        } else if let first = options.first {
            selectedOptions = [first]
        }
    }
    
    func selectAllIsSelected() -> Bool {
        selectedOptions == options
    }
    
    func didToggleOptionSelection(for option: String) {
        if let index = selectedOptions.firstIndex(of: option) {
            guard selectedOptions.count > 1 else { return }
            selectedOptions.remove(at: index)
        } else {
            selectedOptions.insert(option, at: 0)
        }
    }
    
    func optionIsSelected(for option: String) -> Bool {
        selectedOptions.contains(option)
    }
}
