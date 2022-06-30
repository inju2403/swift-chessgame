//
//  BoardView.swift
//  ChessGame
//
//  Created by joel.inju on 2022/06/27.
//

import Combine
import UIKit

import SnapKit

class BoardView: UIView {
    var itemViews: [[BoardItemView]]?
    
    let touchEventSubject = PassthroughSubject<Position, Never>()
    private var subscriptions = Set<AnyCancellable>()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .systemGray3
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        return stackView
    }()
    
    init(_ itemViews: [[BoardItemView]]?) {
        super.init(frame: .zero)
        
        self.itemViews = itemViews
        setItemViews()
        bindConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectItemView(_ position: Position?) {
        guard
            let itemViews = itemViews,
            let position = position
        else {
            return
        }
        
        let y = position.y
        let x = position.x
        
        itemViews[y][x].bgView.backgroundColor = .systemRed
    }
    
    func deselectItemView(_ tuple: (Position, UIColor)?) {
        guard
            let itemViews = itemViews,
            let tuple = tuple
        else {
            return
        }
        
        let position = tuple.0
        let color = tuple.1
        
        let y = position.y
        let x = position.x
        
        itemViews[y][x].bgView.backgroundColor = color
    }
    
    func updateItemViews(_ board: Board) {
        guard let itemViews = itemViews else {
            return
        }
        
        let chessmans = board.position
        for y in 0...7 {
            for x in 0...7 {
                itemViews[y][x].updateChessman(chessmans[y][x])
            }
        }
    }
    
    private func setItemViews() {
        guard let itemViews = itemViews else {
            return
        }
        
        for y in 0...7 {
            for x in 0...7 {
                let itemView = itemViews[y][x]
                itemView.$touched
                    .sink { [weak self] position in
                        guard let position = position else {
                            return
                        }
                        self?.touchEventSubject.send(position)
                    }
                    .store(in: &subscriptions)
            }
        }

        for index in 0...7 {
            let rankStackView = RankStackView(itemViews[index])
            stackView.addArrangedSubview(rankStackView)
        }
        paintItemViews()
    }
    
    private func bindConstraints() {
        self.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func paintItemViews() {
        guard let itemViews = itemViews else {
            return
        }
        
        for y in 0...7 {
            for x in 0...7 {
                itemViews[y][x].bgView.backgroundColor = (y+x) % 2 == 1 ? .systemBrown : .white
            }
        }
    }
}
