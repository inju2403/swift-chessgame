//
//  Queen.swift
//  ChessGame
//
//  Created by joel.inju on 2022/06/20.
//

struct Queen: Chessman {
    var score: Int = 9
    var type: ChessmanType
    var color: ChessmanColor
    var shape: String
    var position: Position
    
    init(_ type: ChessmanType, _ color: ChessmanColor, _ position: Position) {
        self.type = type
        self.color = color
        if color == .black {
            self.shape = "♛"
        } else {
            self.shape = "♕"
        }
        self.position = position
    }
}
