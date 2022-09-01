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
        HStack {
            ToggleView(options: neighborhoods, optionToString: { $0.name }, selected: $selectedNeighborhood)
            
            SelectorView(typeString: GenreType.description, options: genreOptions, optionToString: { $0.rawValue }, selected: $selectedGenres)
            
            SelectorView(typeString: VibeType.description, options: vibeOptions, optionToString: { $0.rawValue }, selected: $selectedVibes)
            
            Spacer()
        }
        .padding([.top], 6)
        .padding([.leading])
//        .background(
//            Color.white
//                .padding([.bottom], -4)
//                .shadow(color: .gray, radius: 5, x: 0, y: 0)
//                .mask(Rectangle().padding(.bottom, -5))
//        )
    }
}

//struct FiltersToolBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        FiltersToolBarView(neighborhoods: <#T##[NeighborhoodItem]#>, genreOptions: <#T##[GenreType]#>, vibeOptions: <#T##[VibeType]#>, selectedNeighborhood: <#T##Binding<NeighborhoodItem>#>, selectedGenres: <#T##Binding<Set<GenreType>>#>, selectedVibes: <#T##Binding<Set<VibeType>>#>)
//    }
//}
