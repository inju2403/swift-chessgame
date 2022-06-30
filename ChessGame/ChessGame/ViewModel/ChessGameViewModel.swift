//
//  ChessGameViewModel.swift
//  ChessGame
//
//  Created by joel.inju on 2022/06/20.
//

import Combine
import Foundation

class ChessGameViewModel {
    @Published var board: Board
    @Published var whiteScore: Int
    @Published var blackScore: Int
    @Published var selectedItemView: BoardItemView?
    var possiblePositions = [String]()
    private var subscriptions = Set<AnyCancellable>()
    
    init(board: Board, whiteScore: Int = 38, blackScore: Int = 38) {
        self.board = board
        self.whiteScore = whiteScore
        self.blackScore = blackScore
    }
    
    /// 단위테스트에 사용되는 함수
    func receiveInput(_ input: String) -> Bool {
        let isPossible = perform(input)
        return isPossible
    }
    
    /// 이 함수에서 명령을 처리하여 boardPosition을 업데이트한다.
    /// 처리할 수 없는 명령에서는 false를 리턴한다.
    func perform(_ input: String) -> Bool {
        let command = Array(input)
        switch isValidInput(command) {
        case .move:
            // 이동 명령을 수행하고 board, whiteScore, blackScore를 업데이트한다.
            let curY = Rank(rawValue: command[1])!.index
            let curX = File(rawValue: command[0].lowercased())!.index
            
            let nextY = Rank(rawValue: command[5])!.index
            let nextX = File(rawValue: command[4].lowercased())!.index
            
            if let mover = board.position(curY, curX) {
                if let destinationChessman = board.position(nextY, nextX) {
                    // 도착지에 체스말이 있을 때
                    if mover.color != destinationChessman.color {
                        board.setChessman(nextY, nextX, mover)
                        board.setChessman(curY, curX, nil)
                        updateScore(destinationChessman)
                        return true
                    } else {
                        return false
                    }
                } else {
                    // 도착지에 체스말이 없을 때
                    board.setChessman(nextY, nextX, mover)
                    board.setChessman(curY, curX, nil)
                    return true
                }
            }
            
            return false
        case .help:
            // 이동 가능한 위치를 possiblePositions에 저장한다.
            possiblePositions = []
            let curY = Rank(rawValue: command[2])!.index
            let curX = File(rawValue: command[1].lowercased())!.index
            
            if let chessman = board.position(curY, curX) {
                switch chessman.type {
                case .pawn:
                    judgePossiblePositionsPawn(curY, curX, chessman)
                case .bishop:
                    judgePossiblePositionsBishop(curY, curX, chessman)
                case .luke:
                    judgePossiblePositionsLuke(curY, curX, chessman)
                case .queen:
                    judgePossiblePositionsQueen(curY, curX, chessman)
                case .knight:
                    judgePossiblePositionsKnight(curY, curX, chessman)
                }
                return true
            }
            return false
        case .invalid:
            return false
        }
    }
    
    /// 인풋을 검사하는 함수
    func isValidInput(_ command: [Character]) -> ChessInput {
        guard command.count == 3 || command.count == 6 else {
            return .invalid
        }
        
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
    
    func setTouchEvent(_ boardView: BoardView) {
        guard let itemViews = boardView.itemViews else {
            return
        }
        
        for y in 0...7 {
            for x in 0...7 {
                let itemView = itemViews[y][x]
                itemView.$touched
                    .sink { [weak self] touched in
                        guard
                            touched == true,
                            let self = self,
                            let posNum = itemView.posNum()
                        else {
                            return
                        }
                        
                        guard let selectedItemView = self.selectedItemView else {
                            // 체스판 위에 선택된 말이 없을 때
                            itemView.bgView.backgroundColor = .systemRed
                            self.selectedItemView = itemView
                            return
                        }
                        
                        if selectedItemView == itemView {
                            // 체스판 위에 선택된 말이 자기 자신일 때
                            itemView.bgView.backgroundColor = posNum % 2 == 1 ? .systemBrown : .white
                            self.selectedItemView = nil
                        } else {
                            // 체스판 위에 선택된 말이 다른 말일 때
                            // 이동 관련 로직 처리 TODO - perform 함수를 이용하여 이동 관련 로직을 처리하고 Board를 업데이트한다.
                            
                            
                            // 다른 말로 포커싱을 바꾼다.
                            guard let posNum = selectedItemView.posNum() else { return }
                            selectedItemView.bgView.backgroundColor = posNum % 2 == 1 ? .systemBrown : .white
                            itemView.bgView.backgroundColor = .systemRed
                            self.selectedItemView = itemView
                        }
                    }
                    .store(in: &subscriptions)
            }
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
    
    func isRange(_ y: Int, _ x: Int) -> Bool {
        if y < 0 || y > 7 || x < 0 || x > 7 {
            return false
        }

        return true
    }
    
    func updateScore(_ chessman: Chessman) {
        switch chessman.color {
        case .black:
            blackScore -= chessman.score
        case .white:
            whiteScore -= chessman.score
        }
    }
    
    func judgePossiblePositionsPawn(_ curY: Int, _ curX: Int, _ chessman: Chessman) {
        var nextY: Int
        var nextX: Int
        
        switch chessman.color {
        case .black:
            nextY = curY - 1
            nextX = curX
        case .white:
            nextY = curY + 1
            nextX = curX
        }
        
        if isRange(nextY, nextX) == true {
            guard let destinationChessman = board.position(nextY, nextX) else {
                possiblePositions.append(positionToString(nextY, nextX))
                return
            }
            
            if destinationChessman.color == .white {
                possiblePositions.append(positionToString(nextY, nextX))
            }
        }
    }
    
    func judgePossiblePositionsBishop(_ curY: Int, _ curX: Int, _ chessman: Chessman) {
        
    }
    
    func judgePossiblePositionsLuke(_ curY: Int, _ curX: Int, _ chessman: Chessman) {
        
    }
    
    func judgePossiblePositionsQueen(_ curY: Int, _ curX: Int, _ chessman: Chessman) {
        
    }
    
    func judgePossiblePositionsKnight(_ curY: Int, _ curX: Int, _ chessman: Chessman) {
        
    }
    
    func positionToString(_ y: Int, _ x: Int) -> String {
        // x - file / y - rank
        return String(UnicodeScalar(Int(UnicodeScalar("A").value) + x)!) + String(y-1)
    }
}

enum ChessInput {
    case move
    case help
    case invalid
}

enum File: String {
    case a
    case b
    case c
    case d
    case e
    case f
    case g
    case h

    var index: Int {
        switch self {
        case .a:
            return 0
        case .b:
            return 1
        case .c:
            return 2
        case .d:
            return 3
        case .e:
            return 4
        case .f:
            return 5
        case .g:
            return 6
        case .h:
            return 7
        }
    }
}

enum Rank: Character {
    case r1 = "1"
    case r2 = "2"
    case r3 = "3"
    case r4 = "4"
    case r5 = "5"
    case r6 = "6"
    case r7 = "7"
    case r8 = "8"

    var index: Int {
        switch self {
        case .r1:
            return 0
        case .r2:
            return 1
        case .r3:
            return 2
        case .r4:
            return 3
        case .r5:
            return 4
        case .r6:
            return 5
        case .r7:
            return 6
        case .r8:
            return 7
        }
    }
}
