//
//  King.swift
//  Chess
//
//  Created by fran on 2022/06/23.
//

import Foundation

class King {
    var color: PieceColor
    var x: Int
    var y: Int

    init() {
        color = .black
        x = 0
        y = 0
    }
    
    func setPosition(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    func setPosition(input: String) {
        guard input.count == 2 else {
            print("error")
            return
        }
        
        let command = Array(input)
        let firstChar = String(command.first!).lowercased()
        let secondChar = String(command.last!)
        
        x = File(rawValue: firstChar)!.index
        y = Rank(rawValue: secondChar)!.index
    }
}

enum PieceColor {
    case black
    case white
}

enum File: String {
    case a
    case b
    case c
    case d
    case e
    case f
    case g
    case h
    
    var index: Int {
        switch self {
        case .a:
            return 0
        case .b:
            return 1
        case .c:
            return 2
        case .d:
            return 3
        case .e:
            return 4
        case .f:
            return 5
        case .g:
            return 6
        case .h:
            return 7
        }
    }
}

enum Rank: String {
    case r1 = "1"
    case r2 = "2"
    case r3 = "3"
    case r4 = "4"
    case r5 = "5"
    case r6 = "6"
    case r7 = "7"
    case r8 = "8"
    
    var index: Int {
        switch self {
        case .r1:
            return 0
        case .r2:
            return 1
        case .r3:
            return 2
        case .r4:
            return 3
        case .r5:
            return 4
        case .r6:
            return 5
        case .r7:
            return 6
        case .r8:
            return 7
        }
    }
}


