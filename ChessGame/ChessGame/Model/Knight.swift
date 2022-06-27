//
//  Knight.swift
//  ChessGame
//
//  Created by joel.inju on 2022/06/20.
//

struct Knight: Chessman {
    var score: Int = 3
    var type: ChessmanType
    var color: ChessmanColor
    
    init(type: ChessmanType, color: ChessmanColor) {
        self.type = type
        self.color = color
    }
}
