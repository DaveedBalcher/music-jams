//
//  FiltersToolBarView.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 9/1/22.
//

import SwiftUI
import MusicVenues

struct FiltersToolbarView: View {
    let neighborhoods: [NeighborhoodItem]
    let genreOptions: [GenreType]
    let vibeOptions: [VibeType]
    
    @Binding var selectedNeighborhood: NeighborhoodItem
    @Binding var selectedGenres: Set<GenreType>
    @Binding var selectedVibes: Set<VibeType>
    
    var body: some View {
        VStack {
            HStack {
                ToggleView(options: neighborhoods, optionToString: { $0.name }, selected: $selectedNeighborhood)
                
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
        let initialNeighborhood = NeighborhoodMapModel.initialState.neighborhoodItem
        
        ZStack {
            VStack {
                FiltersToolbarView(neighborhoods: [initialNeighborhood],
                                   genreOptions: [],
                                   vibeOptions: [],
                                   selectedNeighborhood: .constant(initialNeighborhood),
                                   selectedGenres: .constant([]),
                                   selectedVibes: .constant([])
                )
                Color.red
            }
        }
    }
}
