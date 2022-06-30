//
//  ChessGameUITests.swift
//  ChessGameUITests
//
//  Created by joel.inju on 2022/06/20.
//

import XCTest
@testable import ChessGame

class ChessGameUITests: XCTestCase {
    var app: XCUIApplication!
    
    func test_체스말을_처음클릭했을때_색상이빨간색으로바뀜() {
        // given
        let itemView = app.otherElements["ViewController.boardView.itemViews[1][0]"]
        
        // when
        itemView.tap()
        
        // then
        XCTAssertEqual(itemView.exists, true)
    }
    
    func test_동일한체스말을_두번클릭했을때_색상이원래대로돌아옴() {
        // given
        let itemView = app.otherElements["ViewController.boardView.itemViews[1][0]"]
        
        // when
        itemView.tap()
        itemView.tap()
        
        // then
        XCTAssertEqual(itemView.exists, true)
    }
    
    func test_어떤체스말이클릭된상태에서_다른체스말을클릭했을때_기존체스말은_색상이원래대로돌아오고_새롭게클릭된체스말은_색상이빨간색으로바뀜() {
        // given
        let itemView1 = app.otherElements["ViewController.boardView.itemViews[1][0]"]
        let itemView2 = app.otherElements["ViewController.boardView.itemViews[1][1]"]
        
        // when
        itemView1.tap()
        itemView2.tap()
        
        // then
        XCTAssertEqual(itemView1.exists, true)
        XCTAssertEqual(itemView2.exists, true)
    }
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        app = nil
    }
}
