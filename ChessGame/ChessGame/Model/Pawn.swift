//
//  Pawn.swift
//  ChessGame
//
//  Created by joel.inju on 2022/06/20.
//

import Foundation

struct Pawn: Chessman {
    var score: Int = 1
    var color: ChessmanColor
    
    init(color: ChessmanColor) {
        self.color = color
    }
}
