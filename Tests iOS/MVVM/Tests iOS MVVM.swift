//
//  Tests iOS MVVM.swift
//  Tests iOS
//
//  Created by Sona Sargsyan on 08.06.22.
//

import XCTest
@testable import CollageGlowing

class Tests_iOS_MVVM: XCTestCase {
    let view = ListView(viewModel: ListViewModelImpl().toAnyViewModel())

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

    func testExample() throws {
        XCTAssertTrue(view.viewModel.state.list.isEmpty)
        //TO DO
    }

    func testPerformanceExample() throws {
        self.measure {
            
        }
    }

}
