//
//  BoardView.swift
//  ChessGame
//
//  Created by joel.inju on 2022/06/27.
//

import UIKit

import SnapKit

class BoardView: UIView {
    var itemViews = [[BoardItemView]]()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .systemGray3
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        return stackView
    }()
    
    init(_ itemViews: [[BoardItemView]]) {
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
    
    private func setItemViews() {
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
        for y in 0...7 {
            for x in 0...7 {
                itemViews[y][x].bgView.backgroundColor = (y+x) % 2 == 1 ? .systemBrown : .white
            }
        }
    }
}
