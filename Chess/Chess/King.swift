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
}

enum PieceColor {
    case black
    case white
}

enum File {
    case a
    case b
    case c
    case d
    case e
    case f
    case g
    case h
}

enum Rank: String {
    case r1
    case r2
    case r3
    case r4
    case r5
    case r6
    case r7
    case r8
}


