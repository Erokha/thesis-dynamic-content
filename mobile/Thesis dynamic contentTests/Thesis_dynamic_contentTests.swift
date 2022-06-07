//
//  Thesis_dynamic_contentTests.swift
//  Thesis dynamic contentTests
//
//  Created by erokha on 5/27/22.
//

import XCTest
@testable import Thesis_dynamic_content

class Thesis_dynamic_contentTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        let data = MockViewGenerator().generateViewWith(numberOfSubviews: 1000)
        let viewController = ResearchViewController()
        self.measureMetrics([XCTPerformanceMetric.wallClockTime], automaticallyStartMeasuring: false) {
            startMeasuring()
            viewController.layoutData(data: data)
            stopMeasuring()
        }
        let secondData = MockViewGenerator().generateViewWith(numberOfSubviews: 500)
        let secondViewController = ResearchViewController()
        self.measureMetrics([XCTPerformanceMetric.wallClockTime], automaticallyStartMeasuring: false) {
            startMeasuring()
            secondViewController.layoutData(data: secondData)
            stopMeasuring()
        }
    }

//    func testPerformanceExample() throws {
//        let generator = MockViewGenerator()
//        let sizes = [
//            100,
//            500,
//            1000,
//            5000,
//            10000,
//            50000,
//            100000,
//        ]
//        for size in sizes {
//            let data = generator.generateViewWith(numberOfSubviews: size)
//            let viewController = ResearchViewController()
//            measure {
//                viewController.layoutData(data: data)
//            }
//        }
//    }

}
