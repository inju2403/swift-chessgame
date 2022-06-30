//
//  Chessman.swift
//  ChessGame
//
//  Created by joel.inju on 2022/06/20.
//

protocol Chessman {
    var score: Int { get }
    var type: ChessmanType { get }
    var color: ChessmanColor { get }
    var shape: String { get }
    var position: Position { get set }
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

struct Position: Hashable {
    var y: Int
    var x: Int
    
    var posNum: Int {
        return y + x
    }
}
