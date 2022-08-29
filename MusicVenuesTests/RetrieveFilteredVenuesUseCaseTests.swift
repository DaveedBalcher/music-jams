//
//  RetrieveFilteredVenuesUseCaseTests.swift
//  MusicVenuesTests
//
//  Created by Daveed Balcher on 8/25/22.
//

import XCTest
import MusicVenues

class FilterStore {
    var genreFilterOptions = [GenreType]()
    var vibeFilterOptions = [VibeType]()
    
    func setFilterOptions(with venues: [VenueItem]) {
        genreFilterOptions = venues.getGenres()
        vibeFilterOptions = venues.getVibes()
    }
    
    func userAdd(genreOption: GenreType) {
        
    }
}

class RetrieveFilteredVenuesUseCaseTests: XCTestCase {

    func test_userAddFilterOptions_filterStoreIsEmptyAfterAddingEmptyFilterOptionsToEmptyFilterStore() {
        let sut = FilterStore()
        
        XCTAssertEqual(sut.genreFilterOptions, [])
        XCTAssertEqual(sut.vibeFilterOptions, [])
    }

}
