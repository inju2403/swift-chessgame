//
//  Chessman.swift
//  ChessGame
//
//  Created by joel.inju on 2022/06/20.
//

import Foundation

protocol Chessman {
    var score: Int { get }
    var color: ChessmanColor { get }
}

enum ChessmanColor {
    case black
    case white
}
