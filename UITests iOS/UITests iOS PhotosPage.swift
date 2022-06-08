//
//  UITests iOS PhotosPage.swift
//  UITests iOS
//
//  Created by Sona Sargsyan on 08.06.22.
//

import XCTest

class UITests_iOS_PhotosPage: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        
    }

    override func tearDownWithError() throws {
        app.tables.firstMatch.swipeDown()
    }

    func testNavigation(){
        let navigationTitel = app.navigationBars["Photos 🌸"]
        XCTAssertTrue(navigationTitel.exists)

        let navigationImage = app.images["gelato"]
        XCTAssertTrue(navigationImage.exists)
    }
    
    func testList() {
        let isExistList = app.tables.firstMatch.waitForExistence(timeout: 10)
        XCTAssertTrue(isExistList)
        XCTAssertTrue(app.tables.firstMatch.exists)

        let listCount = app.tables.firstMatch.cells.count
        XCTAssertTrue(listCount > 0)
    }
    
    func testListScrolling() {
        let firstCell =  app.tables.firstMatch.cells.firstMatch
        app.tables.firstMatch.swipeUp()
        let cell = app.tables.firstMatch.cells.firstMatch
        XCTAssertNotEqual(cell, firstCell)
    }
}
