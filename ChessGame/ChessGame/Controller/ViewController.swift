//
//  ViewController.swift
//  ChessGame
//
//  Created by joel.inju on 2022/06/20.
//

import Combine
import UIKit

import SnapKit

class ViewController: UIViewController {
    private var boardView = BoardView()
    private var manager: ChessGameManager?
    private var selectedItemView: BoardItemView?
    private var subscriptions = Set<AnyCancellable>()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 30)
        label.textColor = .systemBrown
        label.text = "Chess Game"
        return label
    }()
    
    private let blackScoreLabel: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    private let whiteScoreLabel: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setManager()
        makeBoardView()
        setViews()
        setTouchEvents()
        observeScore()
        setAccessibilityIdentifier()
    }
    
    private func setManager() {
        var boardPosition = [[Chessman?]](repeating: [Chessman?](repeating: nil, count: 0), count: 8)
        var positions = [[Position]](repeating: [Position](repeating: Position(y:0, x:0), count: 0), count: 8)
        for y in 0...7 {
            for x in 0...7 {
                positions[y].append(Position(y: y, x: x))
            }
        }
        
        boardPosition[0].append(Luke(.luke, .black, positions[0][0]))
        boardPosition[0].append(Knight(.knight, .black, positions[0][1]))
        boardPosition[0].append(Bishop(.bishop, .black, positions[0][2]))
        boardPosition[0].append(nil)
        boardPosition[0].append(Queen(.queen, .black, positions[0][4]))
        boardPosition[0].append(Bishop(.bishop, .black, positions[0][5]))
        boardPosition[0].append(Knight(.knight, .black, positions[0][6]))
        boardPosition[0].append(Luke(.luke, .black, positions[0][7]))
        
        for x in 0...7 {
            boardPosition[1].append(Pawn(.pawn, .black, positions[1][x]))
        }
        
        for index in 2...5 {
            for _ in 0...7 {
                boardPosition[index].append(nil)
            }
        }
        
        for x in 0...7 {
            boardPosition[6].append(Pawn(.pawn, .white, positions[6][x]))
        }
        
        boardPosition[7].append(Luke(.luke, .white, positions[7][0]))
        boardPosition[7].append(Knight(.knight, .white, positions[7][1]))
        boardPosition[7].append(Bishop(.bishop, .white, positions[7][2]))
        boardPosition[7].append(nil)
        boardPosition[7].append(Queen(.queen, .white, positions[7][4]))
        boardPosition[7].append(Bishop(.bishop, .white, positions[7][5]))
        boardPosition[7].append(Knight(.knight, .white, positions[7][6]))
        boardPosition[7].append(Luke(.luke, .white, positions[7][7]))
        
        manager = ChessGameManager(boardPosition: boardPosition)
    }

    private func makeBoardView() {
        guard let boardPosition = manager?.boardPosition else {
            return
        }
        
        var itemViews = [[BoardItemView]](repeating: [BoardItemView](repeating: BoardItemView(), count: 0), count: 8)
        for y in 0...7 {
            for x in 0...7 {
                itemViews[y].append(BoardItemView(boardPosition[y][x]))
            }
        }
        
        boardView = BoardView(itemViews)
    }

    private func setViews() {
        view.backgroundColor = .systemGray2
        view.addSubview(titleLabel)
        view.addSubview(boardView)
        view.addSubview(blackScoreLabel)
        view.addSubview(whiteScoreLabel)
        
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.boardView.snp.top).offset(-100)
            $0.centerX.equalToSuperview()
        }
        
        boardView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.lessThanOrEqualTo(boardView.snp.width)
        }
        
        blackScoreLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30)
            $0.top.equalTo(self.boardView.snp.bottom).offset(40)
        }
        
        whiteScoreLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30)
            $0.top.equalTo(self.blackScoreLabel.snp.bottom).offset(10)
        }
    }
    
    private func setTouchEvents() {
        // 이 로직을 ChessGameManager에서 처리하도록 변경 예정
        for y in 0...7 {
            for x in 0...7 {
                let itemView = boardView.itemViews[y][x]
                itemView.$touched
                    .sink { [weak self] touched in
                        guard
                            touched == true,
                            let self = self,
                            let chessman = itemView.chessman
                        else {
                            return
                        }
                        
                        guard let selectedItemView = self.selectedItemView else {
                            // 체스판 위에 선택된 말이 없을 때
                            itemView.bgView.backgroundColor = .systemRed
                            self.selectedItemView = itemView
                            return
                        }
                        
                        if selectedItemView == itemView {
                            // 체스판 위에 선택된 말이 자기 자신일 때
                            let posNum = chessman.position.posNum
                            itemView.bgView.backgroundColor = posNum % 2 == 1 ? .systemBrown : .white
                            self.selectedItemView = nil
                        } else {
                            // 체스판 위에 선택된 말이 다른 말일 때
                            // 이동 관련 로직 처리 TODO - Board를 업데이트하고 뷰를 다시 그린다.
                            
                            // 다른 말로 포커싱을 바꾼다.
                            guard let posNum = selectedItemView.chessman?.position.posNum else { return }
                            selectedItemView.bgView.backgroundColor = posNum % 2 == 1 ? .systemBrown : .white
                            itemView.bgView.backgroundColor = .systemRed
                            self.selectedItemView = itemView
                        }
                    }
                    .store(in: &subscriptions)
            }
        }
    }
    
    private func observeScore() {
        guard let manager = manager else {
            return
        }

        manager.$blackScore
            .sink { [weak self] blackScore in
                self?.blackScoreLabel.text = "black score: \(blackScore)"
            }
            .store(in: &subscriptions)
        
        manager.$whiteScore
            .sink { [weak self] whiteScore in
                self?.whiteScoreLabel.text = "white score: \(whiteScore)"
            }
            .store(in: &subscriptions)
    }
    
    /// UITest를 위한 코드
    private func setAccessibilityIdentifier() {
        for y in 0...7 {
            for x in 0...7 {
                boardView.itemViews[y][x].accessibilityIdentifier = "ViewController.boardView.itemViews[\(y)][\(x)]"
            }
        }
    }
}

