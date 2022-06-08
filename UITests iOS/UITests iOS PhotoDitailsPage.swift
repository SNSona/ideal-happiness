//
//  UITests iOS PhotoDitailsPage.swift
//  UITests iOS
//
//  Created by Sona Sargsyan on 08.06.22.
//

import XCTest

class UITests_iOS_PhotoDitailsPage: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        app.tables.firstMatch.cells.firstMatch.tap()
    }

    override func tearDownWithError() throws {
        
    }

    func testPhotoDitailsElement() throws {
        let navigationPhotosButton = app.navigationBars.buttons["Photos 🌸"]
        XCTAssertTrue(navigationPhotosButton.exists)
        
        let navigationSaveButton = app.navigationBars.buttons["Save"]
        XCTAssertTrue(navigationSaveButton.exists)
        
        let navigationShareButton = app.navigationBars.buttons["Share"]
        XCTAssertTrue(navigationShareButton.exists)
    }
    
    func testBackButonAction() {
        let navigationPhotosButton = app.navigationBars.buttons["Photos 🌸"]
        navigationPhotosButton.tap()
        let isNavigateBackButton = app.images["gelato"].waitForExistence(timeout: 3)
        XCTAssertTrue(isNavigateBackButton)
        app.tables.firstMatch.cells.firstMatch.tap()
    }
    
    func testShareButtonAction() {
        let navigationShareButton = app.navigationBars.buttons["Share"]
        navigationShareButton.tap()
        let activityListView = app.otherElements["ActivityListView"]
        let isExitActivityListView = activityListView.waitForExistence(timeout: 5)
        XCTAssertTrue(isExitActivityListView)
        
        let isExistCopy = activityListView.collectionViews.buttons["Copy"].waitForExistence(timeout: 3)
        XCTAssertTrue(isExistCopy)
        
        let isExisClose = activityListView.navigationBars["UIActivityContentView"].buttons["Close"].waitForExistence(timeout: 3)
        XCTAssertTrue(isExisClose)
        
        activityListView.navigationBars["UIActivityContentView"].buttons["Close"].tap()
        sleep(5)
        XCTAssertFalse(app.otherElements["ActivityListView"].exists)
    }
}
