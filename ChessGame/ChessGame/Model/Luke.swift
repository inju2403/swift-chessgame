//
//  Luke.swift
//  ChessGame
//
//  Created by joel.inju on 2022/06/20.
//

struct Luke: Chessman {
    var score: Int = 5
    var type: ChessmanType
    var color: ChessmanColor
    var shape: String
    
    init(type: ChessmanType, color: ChessmanColor) {
        self.type = type
        self.color = color
        if color == .black {
            self.shape = "♜"
        } else {
            self.shape = "♖"
        }
    }
}
