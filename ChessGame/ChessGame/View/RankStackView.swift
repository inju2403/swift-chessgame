//
//  RankStackView.swift
//  ChessGame
//
//  Created by joel.inju on 2022/06/28.
//

import UIKit

class RankStackView: UIStackView {
    
    init(_ itemViews: [BoardItemView]) {
        super.init(frame: .zero)
        
        setAttribute()
        configure(itemViews)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAttribute() {
        self.axis = .horizontal
        self.distribution = .equalCentering
        self.alignment = .center
    }
    
    private func configure(_ itemViews: [BoardItemView]) {
        for view in itemViews {
            self.addArrangedSubview(view)
        }
    }
}

