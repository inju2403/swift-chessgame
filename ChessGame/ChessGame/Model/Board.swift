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
    private var board: [Chessman]
    let manager: ChessGameManager
    
    init(board: [Chessman]) {
        self.board = board
        self.manager = ChessGameManager(board: board)
    }
    
    func receiveInput(_ input: String) -> Bool {
        let isPossible = manager.perform(input)
        return isPossible
    }
    
    func observeBoard() {
        manager.$board
            .sink { [weak self] board in
                self?.board = board
            }
            .store(in: &subscriptions)
    }
}
