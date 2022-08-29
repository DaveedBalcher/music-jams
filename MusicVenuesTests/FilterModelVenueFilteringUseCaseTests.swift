//
//  FilterModelVenueFilteringUseCaseTests.swift
//  MusicVenuesTests
//
//  Created by Daveed Balcher on 8/10/22.
//

import XCTest
@testable import MusicVenues

class MockedVenueLoader: VenueLoader {

    private var loadedVenues: [VenueItem] {
        let loadedNeighborhoods = [
            NeighborhoodItem(name: "neighborhood1", center: Coordinates(latitude: 1, longitude: 1), color: nil),
            NeighborhoodItem(name: "neighborhood2", center: Coordinates(latitude: 1, longitude: 1), color: nil)
        ]
        
        let genre1 = GenreType(name: "genre1")
        let genre2 = GenreType(name: "genre2")
        
        return [
            VenueItem(id: UUID(), name: "venue1", imageURL: nil, coordinates: Coordinates(latitude: 1, longitude: 1), neighborhood: loadedNeighborhoods[0], genres: [genre1], vibe: .vibe1),
            VenueItem(id: UUID(), name: "venue2", imageURL: nil, coordinates: Coordinates(latitude: 1, longitude: 1), neighborhood: loadedNeighborhoods[0], genres: [genre1, genre2], vibe: .vibe1),
            VenueItem(id: UUID(), name: "venue3", imageURL: nil, coordinates: Coordinates(latitude: 1, longitude: 1), neighborhood: loadedNeighborhoods[1], genres: [genre2], vibe: .vibe2)
        ]
    }

    
    func retrieveVenues() -> [VenueItem] {
        loadedVenues
    }
    
    func retrieveFilters() -> FilterOptions {
        (genreOptions: loadedVenues.getGenreOptions(), vibeOptions: loadedVenues.getVibeOptions())
    }
    
}

private extension Array where Element: Equatable {
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            guard !uniqueValues.contains(item) else { return }
            uniqueValues.append(item)
        }
        return uniqueValues
    }
}

class FilterModelVenueFilteringUseCaseTests: XCTestCase {

    func test_retrieveVenues_whenNoFiltersAddedReturnAllVenues() {
        let sut = MockedVenueLoader()
        
        let prefilterVenues = sut.retrieveVenues()
        let (postfilterVenues, _, _, _) = sut.retrieveFiltered(filters: [])
        
        XCTAssertEqual(prefilterVenues, postfilterVenues)
    }
    
    func test_retrieveVenues_whenOneGenreFilterIsAddedReturnCorrectFilteredVenues() {
        let sut = MockedVenueLoader()
        
        let parameter = FilterParameter(type: .genres, values: ["genre1"])
        let prefilterVenues = sut.retrieveVenues()
        

        let filteredVenues = FilterProcesser.filter(prefilterVenues, with: [parameter])
        
        let (retrievedFilteredVenues, _, _, _) =  sut.retrieveFiltered(filters: [parameter])
        
        XCTAssertEqual(filteredVenues.count, retrievedFilteredVenues.count)
        
        XCTAssertEqual(2, retrievedFilteredVenues.count)
    }
    
    func test_retrieveVenues_whenTwoGenreFiltersAreAddedReturnCorrectFilteredVenues() {
        let sut = MockedVenueLoader()
        
        let prefilterVenues = sut.retrieveVenues()
        
        let parameter1 = FilterParameter(type: .genres, values: ["genre1", "genre2"])
        let filteredVenues = FilterProcesser.filter(prefilterVenues, with: [parameter1])
        
        let (retrievedFilteredVenues, _, _, _) =  sut.retrieveFiltered(filters: [parameter1])
        
        XCTAssertEqual(filteredVenues.count, retrievedFilteredVenues.count)
        
        XCTAssertEqual(3, retrievedFilteredVenues.count)
    }
    
    func test_retrieveVenues_whenTwoDifferentTypeFiltersAreAddedReturnCorrectFilteredVenues() {
        let sut = MockedVenueLoader()

        let prefilterVenues = sut.retrieveVenues()

        let parameter1 = FilterParameter(type: .genres, values: ["genre1"])
        let parameter2 = FilterParameter(type: .vibes, values: ["vibe2"])
        let filteredVenues = FilterProcesser.filter(prefilterVenues, with: [parameter1, parameter2])

        let (retrievedFilteredVenues, _, _, _) =  sut.retrieveFiltered(filters: [parameter1, parameter2])

        XCTAssertEqual(filteredVenues.count, retrievedFilteredVenues.count)
        
        XCTAssertEqual(0, retrievedFilteredVenues.count)
    }

    // MARK: - Helpers
    
    func AnyFilter() -> FilterParameter {
        FilterParameter(type: .genres, values: ["Any"])
    }
    
    func AnyFilter(with type: FilterType) -> FilterParameter {
        FilterParameter(type: type, values: ["Any"])
    }
}
