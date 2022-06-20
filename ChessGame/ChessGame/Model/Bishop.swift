//
//  Bishop.swift
//  ChessGame
//
//  Created by joel.inju on 2022/06/20.
//

import Foundation

class Bishop: Chessman {
    var score: Int = 3
    var y: Int
    var x: Int
    var color: ChessmanColor
    
    init(y: Int, x: Int, color: ChessmanColor) {
        self.y = y
        self.x = x
        self.color = color
    }
}
