//
//  PlaceMarker.swift
//  MusicJams (iOS)
//
//  Created by Daveed Balcher on 8/1/22.
//

import SwiftUI
import MusicVenues

struct PlaceMarker: View {
    let vm: PlaceViewModel
    let isSelected: Bool
    
    var body: some View {
        ZStack {
            let fillColor = isSelected ? .white : vm.color
            let borderColor = isSelected ? vm.color : .white
            
            if let detail = vm.properties.first,
               let _ = detail.isHighlighted,
               let detailValue = detail.valuesString {
                UrgencyMarker(text: detailValue, labelWidth: 52, fillColor: fillColor, borderColor: borderColor)
            }
                        
            Circle()
                .strokeBorder(borderColor, lineWidth: 1)
                .background(Circle().fill(fillColor))
                .frame(width: 24, height: 24)
            
            vm.image?
                .resizable()
                .scaledToFit()
                .frame(width: 12, height: 12)
                .foregroundColor(vm.color)
                .padding()
        }
    }
}

struct PlaceMarker_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.secondary
            
            let place = Place.preview
            
            PlaceMarker(vm: PlaceViewModel(
                title: place.title,
                image: place.icon,
                properties: place.properties),
                        isSelected: .random()
            )
        }
    }
}
