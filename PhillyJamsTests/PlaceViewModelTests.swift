//
//  PlaceViewModelTests.swift
//  PlaceViewModelTests
//
//  Created by Daveed Balcher on 12/6/22.
//

import SwiftUI
import XCTest
import MusicVenues
@testable import PhillyJams

class PlaceViewModelTests: XCTestCase {
    
    func test_init_initializePlaceViewModelWithPlace() {
        let place = makePlace()
        let vm = PlaceViewModel(place: place)
                                    
        XCTAssertEqual(vm.title, "any place")
        XCTAssertEqual(vm.image, Image(systemName: "music.note"))
        XCTAssertEqual(vm.color, Color("006BB6"))
        XCTAssertEqual(vm.urgencyDescription, "Tomorrow")
        XCTAssertEqual(vm.urgencyDescriptionWidth, 60.3662109375)
        
    }
    
    //MARK: - Helpers
    
    func makeEvent() -> Event {
        Event(title: "any event",
                          description: "",
                          hosts: [],
                          dates: [Date().adding(days: 1)],
                          duration: 60 * 4,
                          isReoccuring: true,
                          properties: [])
    }
    
    func makePlace() -> Place {
        Place(title: "any place",
                          latitude: 0,
                          longitude: 0,
                          regionLevelOne: Region.preview,
                          events: [makeEvent()])
    }
}

extension Date {
    func adding(days: Int, calendar: Calendar = Calendar(identifier: .gregorian)) -> Date {
        return calendar.date(byAdding: .day, value: days, to: self)!
    }
}
