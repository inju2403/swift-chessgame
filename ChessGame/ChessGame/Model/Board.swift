//
//  Board.swift
//  ChessGame
//
//  Created by joel.inju on 2022/06/20.
//

import Foundation

class Board {
    var position: [[Chessman?]]
    
    init(position: [[Chessman?]]) {
        self.position = position
    }
    
    func position(_ y: Int, _ x: Int) -> Chessman? {
        return position[y][x]
    }
    
    func setChessman(_ y: Int, _ x: Int, _ chessman: Chessman?) {
        self.position[y][x] = chessman
    }
}
