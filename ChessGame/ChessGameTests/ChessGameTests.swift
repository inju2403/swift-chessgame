//
//  ChessGameTests.swift
//  ChessGameTests
//
//  Created by joel.inju on 2022/06/20.
//

import XCTest
@testable import ChessGame

class ChessGameTests: XCTestCase {
    func test_A7백색폰앞으로1칸이동_성공케이스() {
        // given
        let board = Board(board: [
            Pawn(y: 1, x: 0, color: ChessmanColor.black),
            Pawn(y: 2, x: 0, color: ChessmanColor.white)
        ])
        board.observeBoard()
        let inputs = ["A2->A1"]
        
        // when
        for input in inputs {
            if board.receiveInput(input) == false {
                XCTFail("test_A7백색폰앞으로1칸이동_성공케이스 실패")
            }
        }
        let result = board.manager.whiteScore - board.manager.blackScore
        
        // then
        XCTAssertEqual(result, 1)
    }
    
    func test_A7백색폰앞으로1칸이동_실패케이스() {
        // given
        let board = Board(board: [
            Pawn(y: 1, x: 0, color: ChessmanColor.white),
            Pawn(y: 2, x: 0, color: ChessmanColor.white)
        ])
        board.observeBoard()
        let inputs = ["A2->A1"]
        
        // when
        for input in inputs {
            if board.receiveInput(input) == true {
                XCTFail("test_A7백색폰앞으로1칸이동_실패케이스 실패")
            }
        }
        let result = board.manager.whiteScore - board.manager.blackScore
        
        // then
        XCTAssertEqual(result, 0)
    }
    
    func test_백색폰_도움말_성공케이스1() {
        // given
        let board = Board(board: [
            Pawn(y: 2, x: 0, color: ChessmanColor.white)
        ])
        board.observeBoard()
        let inputs = ["?A1"]
        
        // when
        for input in inputs {
            _ = board.receiveInput(input)
        }
        
        // then
        let locations = board.manager.possiblePositions
        if locations.count != 1 {
            XCTFail("test_백색폰_도움말_성공케이스1 실패")
        } else {
            XCTAssertEqual(locations[0], "A6")
        }
    }
    
    func test_백색폰_도움말_성공케이스2() {
        // given
        let board = Board(board: [
            Pawn(y: 1, x: 0, color: ChessmanColor.white),
            Pawn(y: 2, x: 0, color: ChessmanColor.white)
        ])
        board.observeBoard()
        let inputs = ["?A2"]
        
        // when
        for input in inputs {
            _ = board.receiveInput(input)
        }
        
        let locations = board.manager.possiblePositions
        
        // then
        XCTAssertEqual(locations.count, 0)
    }
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
}
