//
//  BoardItemView.swift
//  ChessGame
//
//  Created by joel.inju on 2022/06/27.
//

import Combine
import UIKit

import SnapKit

class BoardItemView: UIView {
    private var isSelected = false
    
    let bgView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let chessmanShapeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    var chessman: Chessman? {
        didSet {
            renewView()
        }
    }
    
    @Published var touched = false
    
    private func renewView() {
        chessmanShapeLabel.text = "."
        if let chessman = chessman {
            chessmanShapeLabel.text = chessman.shape
        }
    }
    
    init(_ chessman: Chessman?) {
        super.init(frame: .zero)
        
        self.chessman = chessman
        renewView()
        bindConstraints()
        setTouchEvent()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func bindConstraints() {
        self.addSubview(bgView)
        self.addSubview(chessmanShapeLabel)
        
        bgView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            
            $0.width.equalTo(UIScreen.main.bounds.width / 8)
            $0.height.equalTo(bgView.snp.width)
        }
        
        chessmanShapeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setTouchEvent() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(touchChessman(_:)))
        self.addGestureRecognizer(gesture)
    }
    
    @objc func touchChessman(_ sender: UIGestureRecognizer) {
        touched = true
    }
}
