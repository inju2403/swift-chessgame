//
//  ChessTest.swift
//  ChessTest
//
//  Created by joel.inju on 2022/06/23.
//

import XCTest

class ChessTest: XCTestCase {
    var commander = Commander()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.


    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    func test_생성() {
        guard let king = King(color: .black, input: "D1") else {
            XCTFail()
            return
        }
        //king.setPosition(input: "D1")
        print(king.x, king.y)
        XCTAssertEqual(king.x, 3)
        XCTAssertEqual(king.y, 0)
    }

    func test_초기위치_성공() {
        let blackKing = King(color: .black, input: "D1")
        let whiteKing = King(color: .white, input: "D8")

        XCTAssertNotNil(blackKing, "")
        XCTAssertNotNil(whiteKing, "")

    }

    func test_초기위치_실패() {
        let blackKing = King(color: .black, input: "A2")
        let whiteKing = King(color: .white, input: "D2")

        XCTAssertNil(blackKing, "")
        XCTAssertNil(whiteKing, "")
    }

    func test_이동() {

    }
    
    func test_ex() {
        //XCTFail()


    }

}
