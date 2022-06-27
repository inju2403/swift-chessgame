//
//  Board.swift
//  ChessGame
//
//  Created by joel.inju on 2022/06/20.
//

import Combine
import Foundation

class Board {
    private var subscriptions = Set<AnyCancellable>()
    var position = [[Chessman?]](repeating: [Chessman?](repeating: nil, count: 8), count: 8)
    let manager: ChessGameManager
    
    init(position: [[Chessman?]]) {
        self.position = position
        self.manager = ChessGameManager(boardPosition: position)
    }
    
    func receiveInput(_ input: String) -> Bool {
        let isPossible = manager.perform(input)
        return isPossible
    }
    
    func observeBoard() {
        manager.$boardPosition
            .sink { [weak self] boardPosition in
                self?.position = boardPosition
            }
            .store(in: &subscriptions)
    }
}
