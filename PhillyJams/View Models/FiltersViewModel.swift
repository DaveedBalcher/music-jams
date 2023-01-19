//
//  MainViewModel.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 12/1/22.
//

import Combine
import MusicVenues

// FiltersViewModel - Stores selectedfilters
final class FiltersViewModel: ObservableObject {
    let properties: [Property]
    @Published var selectedProperties: [String:[String]] = [:]
    
    var discription: String {
        let array = [
            getDescription(from: "genres"),
            getDescription(from: "types"),
            getDescription(from: "vibes", hideIfAllSelected: true),
            getDescription(from: "urgency", hideIfAllSelected: true)]
        
        if array.isEmpty { return "All Genres · All Types" }
    
        return array.compactMap { $0 }.joined(separator: " · ")
    }
    
    private func getDescription(from key: String, hideIfAllSelected: Bool = false) -> String? {
        guard let selected = selectedProperties[key] else { return nil }
        if selected == properties.dictonary[key] {
            return hideIfAllSelected ? nil : "All \(key.capitalized)"
        } else if let first = selected.first?.capitalized {
            return selected.count == 1 ? first : "\(first) + \(selected.count-1)"
        } else {
            return nil
        }
    }
    
    init(properties: [Property]) {
        self.properties = properties
    }
    
    init(places: [Place]) {
        var newDict = [String:[String]]()
        let array = places.map { $0.properties.dictonary }
        for dict in array {
            newDict.merge(dict) { Set($0 + $1).sorted() }
        }
        self.properties = newDict.map {
            Property(title: $0.key, values: $0.value)
        }
        
        selectedProperties = properties.dictonary
    }
}
