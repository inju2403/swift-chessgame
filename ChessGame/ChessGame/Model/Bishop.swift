//
//  Bishop.swift
//  ChessGame
//
//  Created by joel.inju on 2022/06/20.
//

import Foundation

struct Bishop: Chessman {
    var score: Int = 3
    var color: ChessmanColor
    
    init(color: ChessmanColor) {
        self.color = color
    }
}
