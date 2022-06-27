//
//  Chessman.swift
//  ChessGame
//
//  Created by joel.inju on 2022/06/20.
//

import Foundation

protocol Chessman {
    var score: Int { get }
    var type: ChessmanType { get }
    var color: ChessmanColor { get }
}

enum ChessmanType {
    case pawn
    case bishop
    case luke
    case queen
    case knight
}

enum ChessmanColor {
    case black
    case white
}
