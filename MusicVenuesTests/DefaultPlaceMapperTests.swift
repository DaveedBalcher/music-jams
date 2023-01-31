//
//  DefaultPlaceMapperTests.swift
//  MusicPlacesTests
//
//  Created by Daveed Balcher on 9/21/22.
//

import XCTest
@testable import MusicVenues

class DefaultPlaceMapperTests: XCTestCase {
    
//    func test_map_mapsDataToLevelOneRegions() {
//        let data = makeJSON(for:[
//            "levelOneRegions": [makeRegion1()],
//            "places": []
//        ])
//
//        let mappedPlaces = DefaultPlaceMapper.map(data)
//        let mappedRegions = mappedPlaces
//
//        let item = makeRegionItem1()
//        XCTAssertEqual(mappedRegions[0].title, item.title)
//        XCTAssertEqual(mappedRegions[0].colorString, item.colorString)
//        XCTAssertEqual(mappedRegions[0].level, item.level)
//    }
    
    func test_map_mapsDataToPlaces() {
        let data = makeJSON(for:[
            "levelOneRegions": [makeRegion1()],
            "places": [makePlace1()]
        ])

        let (_, mappedPlaces) = DefaultPlaceMapper.map(data)

        let item = makePlaceItem1()
        XCTAssertEqual(mappedPlaces.count, 1)
        XCTAssertEqual(mappedPlaces[0].title, item.title)
        XCTAssertEqual(mappedPlaces[0].regionLevelOne, item.regionLevelOne)
        XCTAssertEqual(mappedPlaces[0].longitude, item.longitude)
    }
    
    func test_map_mapsDataToEvents() {
        let data = makeJSON(for:[
            "levelOneRegions": [makeRegion1()],
            "places": [makePlaceWithOneEvent()]
        ])

        let (_, mappedPlaces) = DefaultPlaceMapper.map(data)
        let mappedPlace = mappedPlaces[0]
        let mappedEvent = mappedPlace.events.first
        let placeItem = makePlaceItemWithOneEvent()
        let eventItem = placeItem.events.first
        
        XCTAssertEqual(mappedPlace.events.count, 1)
        XCTAssertEqual(mappedEvent?.title, eventItem?.title)
        XCTAssertEqual(mappedEvent?.dates, eventItem?.dates)
        XCTAssertEqual(mappedEvent?.durationInMinutes, eventItem?.durationInMinutes)
        XCTAssertEqual(mappedEvent?.isReoccuring, eventItem?.isReoccuring)
        XCTAssertEqual(mappedEvent?.properties.count, 3)
        XCTAssertEqual(mappedEvent?.url, eventItem?.url)
    }
    
    func test_map_mapsNextOccuringDateToUrgencyDescriptionProperty() {
        let data = makeJSON(for:[
            "levelOneRegions": [makeRegion1()],
            "places": [makePlaceWithOneEventTomorrow()]
        ])

        let (_, mappedPlaces) = DefaultPlaceMapper.map(data)
        
        XCTAssertEqual(mappedPlaces[0].properties.count, 4)
        XCTAssertEqual(mappedPlaces[0].properties.dictonary["urgency"], ["tomorrow"])
    }
    
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
            "name": "any place",
            "levelOneRegion": "any region",
            "coordinates": [
                -75.1435606,
                 39.9698626
            ],
            "events": []
        ]
    }
    
    func makePlaceItem1() -> Place {
        Place(title: "any place",
              latitude: 39.9698626,
              longitude: -75.1435606,
              regionLevelOne: makeRegionItem1(),
              events: [])
        
    }
    
    func makePlaceWithOneEvent() -> [String: Any] {
        [
            "name": "any place",
            "levelOneRegion": "any region",
            "coordinates": [
                -75.1435606,
                 39.9698626
            ],
            "events": [
                [
                    "name": "any event",
                    "day_of_the_week": "wednesday",
                    "reoccuring": ["weekly"],
                    "start_time": "8:00 PM",
                    "end_time": "12:00 AM",
                    "hosts": ["any host"],
                    "url": "http://www.any-url.com",
                    "properties": [
                        "vibe_index": ["0"],
                        "genres": [
                            "any genre"
                        ],
                        "type": ["any type"]
                    ]
                ]
            ]
        ]
    }
    
    func makePlaceItemWithOneEvent() -> Place {
        let properties = [
            Property(title: "vibe_index", values: ["Beginner-Friendly"]),
            Property(title: "genres", values: ["any genre"]),
            Property(title: "type", values: ["any type"])
        ]
        let date = Date().next(.wednesday, at: 20)
        
        let event = Event(title: "any event",
                          description: "any description",
                          hosts: ["any host"],
                          dates: [
                            date,
                            date.adding(weeks: 1),
                            date.adding(weeks: 2),
                            date.adding(weeks: 3),
                            date.adding(weeks: 4)
                          ],
                          duration: 60 * 4,
                          isReoccuring: true,
                          properties: properties,
                          url: URL(string: "http://www.any-url.com"))
        
        return Place(title: "any place",
                          latitude: 39.9698626,
                          longitude: -75.1435606,
                          regionLevelOne: makeRegionItem1(),
                          events: [event]
        )
    }
    
    func makePlaceWithOneEventTomorrow() -> [String: Any] {
        let date = Date().adding(days: 1)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfTheWeek = dateFormatter.string(from: date)
        
        return [
            "name": "any place",
            "levelOneRegion": "any region",
            "coordinates": [
                -75.1435606,
                 39.9698626
            ],
            "events": [
                [
                    "name": "any event",
                    "day_of_the_week": dayOfTheWeek,
                    "reoccuring": ["weekly"],
                    "start_time": "8:00 PM",
                    "end_time": "12:00 AM",
                    "hosts": ["any host"],
                    "url": "any url",
                    "properties": [
                        "vibe_index": ["0"],
                        "genres": [
                            "any genre"
                        ],
                        "type": ["any type"]
                    ]
                ]
            ]
        ]
    }
}
                                  
extension Date {
    
    func next(_ weekday: Weekday, at time: Int, direction: Calendar.SearchDirection = .forward) -> Date {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(abbreviation: "EST")!
        var components = DateComponents()
        components.weekday = weekday.rawValue
        components.hour = time
        
        if calendar.component(.weekday, from: self) == weekday.rawValue {
            return self
        }
        
        return calendar.nextDate(after: self,
                                 matching: components,
                                 matchingPolicy: .nextTime,
                                 direction: direction)!
    }
    
    func adding(days: Int, calendar: Calendar = Calendar(identifier: .gregorian)) -> Date {
        return calendar.date(byAdding: .day, value: days, to: self)!
    }
    
    func adding(weeks: Int, calendar: Calendar = Calendar(identifier: .gregorian)) -> Date {
        return calendar.date(byAdding: .weekOfYear, value: weeks, to: self)!
    }
    
    enum Weekday: Int {
        case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday
    }
}
