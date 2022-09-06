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
    let genreOptions: [String]
    let vibeOptions: [String]
    
    @Binding var selectedMapRegion: MapRegionItem
    @Binding var selectedGenres: Set<String>
    @Binding var selectedVibes: Set<String>
    
    var body: some View {
        VStack {
            HStack {
                ToggleView(options: mapRegionOptions, optionToString: { $0.name }, selected: $selectedMapRegion)
                
                SelectorView(typeString: GenreType.description, options: genreOptions, optionToString: { $0.rawValue }, selected: $selectedGenres)
                
                SelectorView(typeString: VibeType.description, options: vibeOptions, optionToString: { $0.rawValue }, selected: $selectedVibes)
                
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
                                   genreOptions: [],
                                   vibeOptions: [],
                                   selectedMapRegion: .constant(initialNeighborhood),
                                   selectedGenres: .constant([]),
                                   selectedVibes: .constant([])
                )
                Color.red
            }
        }
    }
}
