//
//  ChessGameManager.swift
//  ChessGame
//
//  Created by joel.inju on 2022/06/20.
//

import Foundation

class ChessGameManager {
    @Published var board: [Chessman]
    var whiteScore: Int
    var blackScore: Int
    var possiblePositions = [String]()
    
    init(board: [Chessman], whiteScore: Int = 38, blackScore: Int = 38) {
        self.board = board
        self.whiteScore = whiteScore
        self.blackScore = blackScore
    }
    
    /// 이 함수에서 명령을 처리하여 board를 업데이트한다.
    /// 처리할 수 없는 명령에서는 false를 리턴한다.
    func perform(_ input: String) -> Bool {
        switch isValidInput(input) {
        case .move:
            // 이동 명령을 수행하고 board, whiteScore, blackScore를 업데이트한다.
            // do something
            return true
        case .help:
            // 이동 가능한 위치를 possiblePositions에 저장한다.
            // do something
            return true
        case .invalid:
            return false
        }
    }
    
    /// 인풋을 검사하는 함수
    func isValidInput(_ input: String) -> ChessInput {
        // do something
        return .move
    }
}

enum ChessInput {
    case move
    case help
    case invalid
}
