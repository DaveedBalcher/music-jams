//
//  PlaceViewModel.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 11/15/22.
//

import SwiftUI
import MusicVenues

struct PlaceViewModel {
    let title: String
    let image: Image
    let color: Color
    
    let details: [String]
    
    let urgencyDescription: String?
    var urgencyDescriptionWidth: CGFloat {
        urgencyDescription?.size(withAttributes: [.font: UIFont.preferredFont(forTextStyle: .footnote)]).width ?? 0
    }
    
    init(place: Place) {
        self.title = place.title
        self.image = place.icon ?? Image(systemName: "music.note")
        self.color = place.regionLevelOne.color
        
        self.urgencyDescription = place.properties.dictonary["urgency"]?.first?.capitalized
        
        var newDetails = [String]()
        
        if let urgencyDescription = urgencyDescription {
            newDetails.append("Next event: \(urgencyDescription)")
        }
        
        var newDescription = [String]()
        
        if let vibes = (place.properties.dictonary["vibes"]?.map { $0 })?.joined(separator: ", ").lowercased() {
            newDescription.append(vibes)
        }
        if let genres = (place.properties.dictonary["genres"]?.map { $0 })?.joined(separator: ", ").lowercased()  {
            newDescription.append(genres.replacingOccurrences(of: "open", with: ""))
        }
        if let types = place.properties.dictonary["types"],
           let type = types.count == 1 ? types.first : "jams and open mics" {
            newDescription.append(type.lowercased())
        }
        
        if newDescription.isEmpty {
            newDetails.append("Regular music events")
        } else {
            let descriptionString = newDescription.joined(separator:" ").removeDuplicateWords().capitalizingFirstLetter()
            newDetails.append(descriptionString)
        }
        
        self.details = newDetails
    }
}

private extension String {
    func removeDuplicateWords() -> String {
        let words = self.split(separator: " ")
        var set = Set<String>()
        var result = [String]()
        for word in words {
            var stringWord = String(word)
            if stringWord.hasSuffix(",") {
                stringWord.removeLast()
            }
            if !set.contains(stringWord) {
                set.insert(stringWord)
                if word.hasSuffix(",") {
                    result.append(stringWord + ",")
                } else {
                    result.append(stringWord)
                }
            }
        }
        return result.joined(separator: " ")
    }
    
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
