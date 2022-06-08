//
//  Tests iOS API.swift
//  Tests iOS
//
//  Created by Sona Sargsyan on 08.06.22.
//

import XCTest
@testable import CollageGlowing

class Tests_iOS_API: XCTestCase {
    let service = ListServiceImpl.shared

    override func setUpWithError() throws {
        XCTAssertEqual(Target.current.host, "https://picsum.photos")
        XCTAssertEqual(Target.current.url(.imageList), "https://picsum.photos/v2/list")
    }

    override func tearDownWithError() throws {
        
    }

    func testRequestImageList() throws {
        service.loadImages()
            .sink(receiveCompletion: { completion in
                switch completion {
                case let .failure(error):
                    XCTAssert(false, error.localizedDescription)
                case .finished:
                    XCTAssertTrue(true)
                }
            }, receiveValue: {  list in
                XCTAssertTrue(list.count > 0)
            })
        //TO DO
    }

    func testPerformanceExample() throws {
       
        self.measure {
           
        }
    }

}
