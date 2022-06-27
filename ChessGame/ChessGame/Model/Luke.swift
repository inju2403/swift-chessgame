//
//  Luke.swift
//  ChessGame
//
//  Created by joel.inju on 2022/06/20.
//

import Foundation

struct Luke: Chessman {
    var score: Int = 5
    var color: ChessmanColor
    
    init(color: ChessmanColor) {
        self.color = color
    }
}
