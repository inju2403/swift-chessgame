//
//  Queen.swift
//  ChessGame
//
//  Created by joel.inju on 2022/06/20.
//

struct Queen: Chessman {
    var score: Int = 9
    var color: ChessmanColor
    
    init(color: ChessmanColor) {
        self.color = color
    }
}
