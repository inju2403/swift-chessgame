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
    
    init(type: ChessmanType, color: ChessmanColor) {
        self.type = type
        self.color = color
    }
}
