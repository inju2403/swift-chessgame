//
//  BoardItemView.swift
//  ChessGame
//
//  Created by joel.inju on 2022/06/27.
//

import UIKit

class BoardItemView: UIView {
    let chessmanShapeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var chessman: Chessman? {
        didSet {
            renewView()
        }
    }
    
    private func renewView() {
        chessmanShapeLabel.text = "."
        if let chessman = chessman {
            chessmanShapeLabel.text = chessman.shape
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        drawView()
    }
    
    private func drawView() {
        
    }
}
