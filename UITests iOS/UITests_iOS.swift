//
//  UITests_iOS.swift
//  UITests iOS
//
//  Created by Sona Sargsyan on 08.06.22.
//

import XCTest

class UITests_iOS: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
//        let navigationTitel = app.navigationBars["Photos 🌸"]
//        XCTAssertTrue(navigationTitel.exists)
//
//        let navigationImage = app.images["gelato"]
//        XCTAssertTrue(navigationImage.exists)
//
//        let listCount = app.tables.firstMatch.cells.count
//        XCTAssertTrue(listCount > 0)
//
//        let firstCell =  app.tables.firstMatch.cells.firstMatch
//        XCTAssertEqual(firstCell, app.tables.firstMatch.cells.firstMatch)
//        app.tables.firstMatch.swipeUp()
//        let cell = app.tables.firstMatch.cells.firstMatch
//        XCTAssertNotEqual(cell, firstCell)
                        
                        
                
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
