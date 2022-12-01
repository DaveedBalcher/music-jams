//
//  DefaultPlaceMapperTests.swift
//  MusicPlacesTests
//
//  Created by Daveed Balcher on 9/21/22.
//

import XCTest
@testable import MusicVenues

class DefaultPlaceMapperTests: XCTestCase {
    
    func test_map_mapsDataToLevelOneRegions() {
        let data = makeJSON(for:[
            "levelOneRegions": [makeRegion1()],
            "places": []
        ])
        
        let (mappedRegions, _) = DefaultPlaceMapper.map(data)
        
        XCTAssertEqual(mappedRegions, [makeRegionItem1()])
    }
    
    func test_map_mapsDataToPlaces() {
        let data = makeJSON(for:[
            "levelOneRegions": [makeRegion1()],
            "places": [makePlace1()]
        ])

        let (_, mappedPlaces) = DefaultPlaceMapper.map(data)

        XCTAssertEqual(mappedPlaces, [makePlaceItem1()])
    }

//    func test_mapToEvents_mapDefaultValuesToEvents() {
//        let defaultDayOfTheWeek = "Wednesday"
//        let defaultStartTime = "9:00PM"
//        let defaultEndTime = "12:00AM"
//        let sut = DefaultPlaceMapper()
//
//        sut
//    }
    
    // MARK: - Helpers
    
    func makeJSON(for dict: [String: [[String: Any]]]) -> Data {
        try! JSONSerialization.data(withJSONObject: dict)
    }
    
    // MARK: - Mocking
    
    func makeRegion1() -> [String: Any] {
        [
            "name": "any region",
            "coordinates": [
                -75.13069152832031,
                 39.98442041689492
            ],
            "color": "f09c1c"
        ]
    }
    
    func makeRegionItem1() -> Region {
        Region(title: "any region",
               colorString: "f09c1c",
               level: .one,
               latitude: 39.98442041689492,
               longitude: -75.13069152832031)
    }
    
    func makePlace1() -> [String: Any] {
        [
            "name": "any name",
            "levelOneRegion": "any region",
            "coordinates": [
              -75.1435606,
              39.9698626
            ]
        ]
    }
    
    func makePlaceItem1() -> Place {
        Place(title: "any name",
              latitude: 39.9698626,
              longitude: -75.1435606,
              regionLevelOne: makeRegionItem1(),
              properties: [])
        
    }
}
