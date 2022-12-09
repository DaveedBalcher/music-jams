//
//  SectionViewModelTests.swift
//  PhillyJamsTests
//
//  Created by Daveed Balcher on 12/8/22.
//

import XCTest
@testable import PhillyJams

final class SectionViewModelTests: XCTestCase {

    func test_didToggleSelectAll_onOneOptionSelectedMakeAllSelected() {
        let sut = SectionViewModel(type: "any type", options: ["test1","test2","test3"], selectedOption: ["test1"])
        
        XCTAssertEqual(sut.selectedOptions, ["test1"])
        sut.didToggleSelectAll()
        
        XCTAssertEqual(sut.selectedOptions, ["test1","test2","test3"])
    }
    
    func test_didToggleSelectAll_onAllOptionsSelectedMakeOneSelected() {
        let sut = SectionViewModel(type: "any type", options: ["test1","test2","test3"], selectedOption: ["test1","test2","test3"])
        
        XCTAssertEqual(sut.selectedOptions, ["test1","test2","test3"])
        sut.didToggleSelectAll()
        
        XCTAssertEqual(sut.selectedOptions, ["test1"])
    }
    
    func test_didToggleOptionSelection_onOneOptionSelectedSelectingTheSameOptionHasNoChange() {
        let sut = SectionViewModel(type: "any type", options: ["test1","test2","test3"], selectedOption: ["test1"])
        
        XCTAssertEqual(sut.selectedOptions, ["test1"])
        sut.didToggleOptionSelection(for: "test1")
        
        XCTAssertEqual(sut.selectedOptions, ["test1"])
    }
    
    func test_didToggleOptionSelection_onOneOptionSelectedSelectASecondOptionAndAddToFrontOfSelectedOptions() {
        let sut = SectionViewModel(type: "any type", options: ["test1","test2","test3"], selectedOption: ["test1"])
        
        XCTAssertEqual(sut.selectedOptions, ["test1"])
        sut.didToggleOptionSelection(for: "test2")
        
        XCTAssertEqual(sut.selectedOptions, ["test2", "test1"])
    }
    
    func test_didToggleOptionSelection_onTwoOptionsSelectedDeselectOneOption() {
        let sut = SectionViewModel(type: "any type", options: ["test1","test2","test3"], selectedOption: ["test1","test3"])
        
        XCTAssertEqual(sut.selectedOptions, ["test1","test3"])
        sut.didToggleOptionSelection(for: "test1")
        
        XCTAssertEqual(sut.selectedOptions, ["test3"])
    }
    
    func test_didToggleOptionSelection_onAllOptionSelectedDeselectOneOption() {
        let sut = SectionViewModel(type: "any type", options: ["test1","test2","test3"], selectedOption: ["test1","test2","test3"])
        
        XCTAssertEqual(sut.selectedOptions, ["test1","test2","test3"])
        sut.didToggleOptionSelection(for: "test2")
        
        XCTAssertEqual(sut.selectedOptions, ["test1", "test3"])
    }

}
