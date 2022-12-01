//
//  PlaceBottomView.swift
//  MusicJams (iOS)
//
//  Created by Daveed Balcher on 8/1/22.
//

import SwiftUI
import MusicVenues

struct PlacePreviewView: View {
    let placeVM: PlaceViewModel
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(placeVM.color)
                    .padding([.leading], 12)
                
                placeVM.image?
                    .resizable()
                    .foregroundColor(Color.white)
                    .padding()
                    .scaledToFit()
            }
            .frame(width: 72, height: 72)
            .padding([.leading], 12)
            .padding([.trailing], 4)
            
            VStack(alignment: .leading) {
                
                Text(placeVM.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(placeVM.color)
                
                VStack(alignment: .leading) {
                    ForEach(placeVM.properties, id: \.self) { property in
                        HStack {
                            Text(property.title.uppercased())
                                .fontWeight(.light)
                            Text(property.valuesString)
                                .foregroundColor(property.isHighlighted ? placeVM.color : Color.accentColor)
                                .fontWeight(property.isHighlighted ? .semibold : .light)
                        }
                    }
                }
                .font(.subheadline)
                .foregroundColor(Color.accentColor)
                
                Spacer()
            }
            .padding([.top], 8)
            
            Spacer()
        }
        
        .frame(maxWidth: .infinity, maxHeight: 96)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white)
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color.accentColor.opacity(0.25))
            }
            .shadow(color: Color.accentColor.opacity(0.25), radius: 8)
        )
        .padding([.leading,.trailing], 12)
    }
}

struct PlacePreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(alignment: .bottom) {
            Color.white
            
            let place = Place.preview

            PlacePreviewView(placeVM: PlaceViewModel(
                title: place.title,
                image: place.icon,
                properties: place.properties)
            )
        }
    }
}
