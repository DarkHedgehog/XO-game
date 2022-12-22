//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    private let gameboard = Gameboard()
    private var strategy: GameStrategy?
    private var timer: Timer?

    private var currentState: GameState! {
        didSet {
            self.currentState.begin()
        }
    }

    private lazy var referee = Referee(gameboard: self.gameboard)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.goToFirstState()
        self.timerStart()
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }

            self.strategy?.onSelectPosition(state: self.currentState, at: position)

            if self.currentState.isCompleted {
                self.goToNextState()
            }
        }
    }


    func configure(strategy: GameStrategy) {
        self.strategy = strategy
    }

    @IBAction func restartButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }

    private func timerStart() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            guard let strategy = self.strategy else {
                return
            }

            strategy.timerState(currentState: self.currentState)

            if self.currentState.isCompleted {
                self.goToNextState()
            }
        }
    }

    private func goToFirstState() {
        guard let strategy = strategy else {
            return
        }

        self.currentState = strategy.initialState(
            player: .first,
            gameViewController: self,
            gameboard: gameboard,
            gameboardView: gameboardView)
    }

    private func goToNextState() {
        guard let strategy = strategy else {
            return
        }

        currentState = strategy.nextState(currentState: currentState,
                                          referee: referee,
                                          gameViewController: self,
                                          gameboard: gameboard,
                                          gameboardView: gameboardView)
        
    }
}
