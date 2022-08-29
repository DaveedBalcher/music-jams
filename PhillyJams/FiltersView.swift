//
//  FiltersView.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/26/22.
//

//import SwiftUI
//import MusicVenues
//
//
//class FilterStore: ObservableObject {
//
//    static var shared = FilterStore()
//
//    private init() {}
//
//    @Published var selectedGenreOptions: Set<SelectableOption>
//    @Published var selectedVibeOptions: Set<SelectableOption>
//
//    func updateOptions(genreOptions: [SelectableOption], vibeOptions: [SelectableOption]) {
//        //Stratagy for combining old with new filter options
//        self.selectedGenreOptions = Set(selectedGenreOptions + genreOptions)
//        self.selectedVibeOptions = Set(selectedVibeOptions + vibeOptions)
//    }
//
//}
//
//struct FiltersView: View {
//
//    let neighborhoods: [NeighborhoodItem]
//    @Binding var selectedNeighborhood: NeighborhoodItem
//
//    let genreOptions: [SelectableOption]
//    let vibeOptions: [SelectableOption]
//
//    @StateObject var filterStore
//
//    var body: some View {
//        HStack {
//            ToggleView(options: neighborhoods, optionToString: { $0.name }, selected: $selectedNeighborhood)
//
//            SelectorView(typeString: GenreType.description, options: genreOptions, selected: $selectedGenreOptions)
//
//            SelectorView(typeString: VibeType.description, options: vibeOptions, selected: $selectedVibeOptions)
//
//            Spacer()
//        }
//        .padding([.leading])
//    }
//
//    init(neighborhoods: [NeighborhoodItem], selectedNeighborhood: Binding<NeighborhoodItem>, genreOptions: [String], vibeOptions: [String]) {
//        self.neighborhoods = neighborhoods
//        self.genreOptions = genreOptions.map { SelectableOption(string: $0) }
//        self.vibeOptions = vibeOptions.map { SelectableOption(string: $0) }
//
//        _filterStore = StateObject(wrappedValue: FilterStore.shared)
//        _filterStore.update()
//    }
//}
//
////struct FiltersView_Previews: PreviewProvider {
////    static var previews: some View {
////        FiltersView()
////    }
////}
//
