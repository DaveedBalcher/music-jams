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
                
                placeVM.image
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
                    HStack(spacing: 0) {
                        Text("Type: ")
                        Text(placeVM.type)
                    }
                    HStack(spacing: 0) {
                        Text("Genres: ")
                        Text(placeVM.genres)
                    }
                    HStack(spacing: 0) {
                        Text("Vibe: ")
                        Text(placeVM.vibes)
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
            
            let place = Place(with: [Event.preview])

            PlacePreviewView(placeVM: PlaceViewModel(place: place)
            )
        }
    }
}
