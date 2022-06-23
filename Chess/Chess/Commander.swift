//
//  Commander.swift
//  Chess
//
//  Created by fran on 2022/06/23.
//

import Foundation

class Commander {
    var king: King
    
    init(king: King) {
        self.king = king
    }
    
    func move(dx: Int, dy: Int) -> Bool {
        let newX = king.x + dx
        let newY = king.y + dy
        
        print("beforeX: \(king.x), beforeY: \(king.y)")
        
        guard king.isRange(x: newX, y: newY) == true else {
            return false
        }
        
        king.x = newX
        king.y = newY
        
        print("afterX: \(king.x), afterY: \(king.y)")
        
        return true
    }
    
    
}
