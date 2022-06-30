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
    private var viewModel: ChessGameViewModel?
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
        
        initViewModel()
        setBoardView()
        setViews()
        setTouchEvents()
        setAccessibilityIdentifier()
    }
    
    private func initViewModel() {
        var chessmans = [[Chessman?]](repeating: [Chessman?](repeating: nil, count: 0), count: 8)
        var positions = [[Position]](repeating: [Position](repeating: Position(y:0, x:0), count: 0), count: 8)
        for y in 0...7 {
            for x in 0...7 {
                positions[y].append(Position(y: y, x: x))
            }
        }
        
        chessmans[0].append(Luke(.luke, .black, positions[0][0]))
        chessmans[0].append(Knight(.knight, .black, positions[0][1]))
        chessmans[0].append(Bishop(.bishop, .black, positions[0][2]))
        chessmans[0].append(nil)
        chessmans[0].append(Queen(.queen, .black, positions[0][4]))
        chessmans[0].append(Bishop(.bishop, .black, positions[0][5]))
        chessmans[0].append(Knight(.knight, .black, positions[0][6]))
        chessmans[0].append(Luke(.luke, .black, positions[0][7]))
        
        for x in 0...7 {
            chessmans[1].append(Pawn(.pawn, .black, positions[1][x]))
        }
        
        for index in 2...5 {
            for _ in 0...7 {
                chessmans[index].append(nil)
            }
        }
        
        for x in 0...7 {
            chessmans[6].append(Pawn(.pawn, .white, positions[6][x]))
        }
        
        chessmans[7].append(Luke(.luke, .white, positions[7][0]))
        chessmans[7].append(Knight(.knight, .white, positions[7][1]))
        chessmans[7].append(Bishop(.bishop, .white, positions[7][2]))
        chessmans[7].append(nil)
        chessmans[7].append(Queen(.queen, .white, positions[7][4]))
        chessmans[7].append(Bishop(.bishop, .white, positions[7][5]))
        chessmans[7].append(Knight(.knight, .white, positions[7][6]))
        chessmans[7].append(Luke(.luke, .white, positions[7][7]))
        
        viewModel = ChessGameViewModel(board: Board(position: chessmans))
        observeViewModel()
    }

    private func setBoardView() {
        guard let board = viewModel?.board else {
            return
        }
        
        let chessmans = board.position
        var itemViews = [[BoardItemView]](repeating: [BoardItemView](repeating: BoardItemView(), count: 0), count: 8)
        for y in 0...7 {
            for x in 0...7 {
                itemViews[y].append(BoardItemView(chessmans[y][x]))
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
        viewModel?.setTouchEvent(boardView)
    }
    
    private func observeViewModel() {
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.$board
            .sink { [weak self] board in
                guard let boardView = self?.boardView else {
                    return
                }
                
                boardView.updateItemViews(board)
            }
            .store(in: &subscriptions)
        
        viewModel.$selectedItemView
            .sink { [weak self] selectedItemView in
                self?.selectedItemView = selectedItemView
            }
            .store(in: &subscriptions)

        viewModel.$blackScore
            .sink { [weak self] blackScore in
                self?.blackScoreLabel.text = "black score: \(blackScore)"
            }
            .store(in: &subscriptions)
        
        viewModel.$whiteScore
            .sink { [weak self] whiteScore in
                self?.whiteScoreLabel.text = "white score: \(whiteScore)"
            }
            .store(in: &subscriptions)
    }
    
    /// UITest를 위한 코드
    private func setAccessibilityIdentifier() {
        guard let itemViews = boardView.itemViews else {
            return
        }
        
        for y in 0...7 {
            for x in 0...7 {
                itemViews[y][x].accessibilityIdentifier = "ViewController.boardView.itemViews[\(y)][\(x)]"
            }
        }
    }
}

