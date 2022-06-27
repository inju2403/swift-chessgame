//
//  ChessGameManager.swift
//  ChessGame
//
//  Created by joel.inju on 2022/06/20.
//

import Foundation

class ChessGameManager {
    @Published var boardPosition: [[Chessman?]]
    var whiteScore: Int
    var blackScore: Int
    var possiblePositions = [String]()
    
    init(boardPosition: [[Chessman?]], whiteScore: Int = 38, blackScore: Int = 38) {
        self.boardPosition = boardPosition
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
        guard input.count == 3 || input.count == 6 else {
            return .invalid
        }
        
        let command = Array(input)
        switch command.count {
        case 3:
            if command[0] == "?"
                && isFile(command[1])
                && isRank(command[2]) {
                return .help
            }
            return .invalid
        case 6:
            if isFile(command[0])
                && isRank(command[1])
                && command[2] == "-"
                && command[3] == ">"
                && isFile(command[4])
                && isRank(command[5]) {
                return .move
            }
            return .invalid
        default:
            return .invalid
        }
    }
    
    func isFile(_ char: Character) -> Bool {
        if char >= "A" && char <= "H" {
            return true
        }
        return false
    }
    
    func isRank(_ char: Character) -> Bool {
        if let rank = Int(String(char)),
           (0...7 ~= rank) {
            return true
        }
        return false
    }
}

enum ChessInput {
    case move
    case help
    case invalid
}
