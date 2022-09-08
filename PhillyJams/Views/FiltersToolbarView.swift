//
//  FiltersToolBarView.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 9/1/22.
//

import SwiftUI
import MusicVenues

struct FiltersToolbarView: View {
    let mapRegionOptions: [MapRegionItem]
    let genreOptions: [GenreType]
    let vibeOptions: [VibeType]
    
    @Binding var selectedMapRegion: MapRegionItem
    @Binding var selectedGenre: GenreType?
    @Binding var selectedVibe: VibeType?
    
    var body: some View {
        VStack {
            HStack {
                ToggleView(options: mapRegionOptions, optionToString: { $0.name }, selected: $selectedMapRegion)
                
                ToggleWithAllView(typeString: GenreType.description, options: genreOptions, optionToString: { $0.rawValue }, selected: $selectedGenre)
                
                ToggleWithAllView(typeString: VibeType.description, options: vibeOptions, optionToString: { $0.rawValue }, selected: $selectedVibe)
                
//                SelectorView(typeString: GenreType.description, options: genreOptions, optionToString: { $0.rawValue }, selected: $selectedGenres)
//
//                SelectorView(typeString: VibeType.description, options: vibeOptions, optionToString: { $0.rawValue }, selected: $selectedVibes)
                
                Spacer()
            }
            .padding([.leading], 8)

            Color.gray
                .opacity(0.3)
                .frame(height: 1)
        }
        .padding([.top], 4)
        .padding([.bottom], -8)
    }
}

struct FiltersToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        let initialNeighborhood = MapRegionItem.initialState
        
        ZStack {
            VStack {
                FiltersToolbarView(mapRegionOptions: [initialNeighborhood],
                                   genreOptions: [GenreType.defaultValue],
                                   vibeOptions: [VibeType.defaultValue],
                                   selectedMapRegion: .constant(initialNeighborhood),
                                   selectedGenre: .constant(GenreType.defaultValue),
                                   selectedVibe: .constant(VibeType.defaultValue)
                )
                Color.red
            }
        }
    }
}
