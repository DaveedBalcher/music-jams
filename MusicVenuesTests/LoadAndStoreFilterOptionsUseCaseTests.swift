//
//  LoadAndStoreFilterOptionsUseCaseTests.swift
//  MusicVenuesTests
//
//  Created by Daveed Balcher on 8/25/22.
//

import XCTest
import MusicVenues

class LoadAndStoreFilterOptionsUseCaseTests: XCTestCase {

    func test_setFilterOptions_setEmptyFilterOptionsFromEmptyVenueItems() {
        let sut = FilterStore()
        let venues: [VenueItem] = []
        
        sut.setFilterOptions(with: venues)
        
        XCTAssertEqual(sut.genreFilterOptions, [])
        XCTAssertEqual(sut.vibeFilterOptions, [])
    }
    
    func test_setFilterOptions_setFilterOptionsFromOneVenueItemWithOneGenreFilterOptions() {
        let sut = FilterStore()
        let genres = [GenreType(name: "Genre1")]
        let venue = VenueItem(name: "Venue1", genres: genres, vibe: .defaultValue)
        let venues: [VenueItem] = [venue]
        
        sut.setFilterOptions(with: venues)
        
        XCTAssertEqual(sut.genreFilterOptions, genres)
    }
    
    func test_setFilterOptions_setFilterOptionsFromOneVenueItemWithOneVibeFilterOption() {
        let sut = FilterStore()
        let vibe = VibeType.vibe1
        let venue = VenueItem(name: "Venue1", genres: [GenreType.defaultValue], vibe: vibe)
        let venues: [VenueItem] = [venue]
        
        sut.setFilterOptions(with: venues)
        
        XCTAssertEqual(sut.vibeFilterOptions, [vibe])
    }
    
    func test_setFilterOptions_setFilterOptionsFromVenueItemsWithOneGenreFilterOption() {
        let sut = FilterStore()
        let genres = [GenreType(name: "Genre1")]
        let venue = VenueItem(name: "Venue1", genres: genres, vibe: .defaultValue)
        let venues: [VenueItem] = [venue, venue]
        
        sut.setFilterOptions(with: venues)
        
        XCTAssertEqual(sut.genreFilterOptions, genres)
    }
    
    func test_setFilterOptions_setFilterOptionsFromVenueItemsWithOneVibeFilterOption() {
        let sut = FilterStore()
        let vibe = VibeType.vibe1
        let venue = VenueItem(name: "Venue1", genres: [GenreType.defaultValue], vibe: vibe)
        let venues: [VenueItem] = [venue, venue]
        
        sut.setFilterOptions(with: venues)
        
        XCTAssertEqual(sut.vibeFilterOptions, [vibe])
    }
    
    func test_setFilterOptions_setFilterOptionsFromOneVenueItemWithOneGenreFilterOptionAndOneVibeFilterOptions() {
        let sut = FilterStore()
        let genres = [GenreType(name: "Genre1")]
        let vibe = VibeType.vibe1
        let venue = VenueItem(name: "Venue1", genres: genres, vibe: vibe)
        let venues: [VenueItem] = [venue]
        
        sut.setFilterOptions(with: venues)
        
        XCTAssertEqual(sut.genreFilterOptions, genres)
        XCTAssertEqual(sut.vibeFilterOptions, [vibe])
    }
    
    func test_setFilterOptions_setFilterOptionsFromVenueItemsWithOneGenreFilterOptionAndOneVibeFilterOptions() {
        let sut = FilterStore()
        let genres = [GenreType(name: "Genre1")]
        let vibe = VibeType.vibe1
        let venue = VenueItem(name: "Venue1", genres: genres, vibe: vibe)
        let venues: [VenueItem] = [venue, venue]
        
        sut.setFilterOptions(with: venues)
        
        XCTAssertEqual(sut.genreFilterOptions, genres)
        XCTAssertEqual(sut.vibeFilterOptions, [vibe])
    }
    
    func test_setFilterOptions_setFilterOptionsFromVenueItemsWithOneUniqueGenreFilterOptionAndOneUniqueVibeFilterOptions() {
        let sut = FilterStore()
        let genres1 = [GenreType(name: "Genre1")]
        let vibe1 = VibeType.vibe1
        let venue1 = VenueItem(name: "Venue1", genres: genres1, vibe: vibe1)
        let genres2 = [GenreType(name: "Genre2")]
        let vibe2 = VibeType.vibe2
        let venue2 = VenueItem(name: "Venue2", genres: genres2, vibe: vibe2)
        let venues: [VenueItem] = [venue1, venue2]
        
        sut.setFilterOptions(with: venues)
        
        XCTAssertEqual(sut.genreFilterOptions, genres1 + genres2)
        XCTAssertEqual(sut.vibeFilterOptions, [vibe1, vibe2])
    }
    
    func test_setFilterOptions_setFilterOptionsFromVenueItemsWithTwoGenreFilterOptionAndOneUniqueVibeFilterOptions() {
        let sut = FilterStore()
        let genres = [GenreType(name: "Genre1"), GenreType(name: "Genre2")]
        let vibe1 = VibeType.vibe1
        let venue1 = VenueItem(name: "Venue1", genres: genres, vibe: vibe1)
        let vibe2 = VibeType.vibe2
        let venue2 = VenueItem(name: "Venue2", genres: genres, vibe: vibe2)
        let venues: [VenueItem] = [venue1, venue2]
        
        sut.setFilterOptions(with: venues)
        
        XCTAssertEqual(sut.genreFilterOptions, genres)
        XCTAssertEqual(sut.vibeFilterOptions, [vibe1, vibe2])
    }
}
