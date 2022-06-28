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
    
    init(type: ChessmanType, color: ChessmanColor) {
        self.type = type
        self.color = color
        if color == .black {
            self.shape = "♛"
        } else {
            self.shape = "♕"
        }
    }
}
