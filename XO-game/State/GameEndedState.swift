//
//  GameEndedState.swift
//  XO-game
//
//  Created by Aleksandr Derevenskih on 21.12.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

public class GameEndedState: GameState {
    public let isCompleted = false
    public private(set) var allowInteraction = false
    public let winner: Player?

    private(set) weak var gameViewController: GameViewController?

    init(winner: Player?, gameViewController: GameViewController) {
        self.winner = winner
        self.gameViewController = gameViewController
    }

    public func begin() {
        gameViewController?.winnerLabel.isHidden = false
        if let winner = winner {
            gameViewController?.winnerLabel.text = winnerName(from: winner) + " win"
        } else {
            gameViewController?.winnerLabel.text = "No winner"
        }
        gameViewController?.firstPlayerTurnLabel.isHidden = true
        gameViewController?.secondPlayerTurnLabel.isHidden = true
    }

    public func addMark(at _: GameboardPosition) -> Bool {
        return false
    }

    private func winnerName(from winner: Player) -> String {
        switch winner {
        case .first: return "1st player"
        case .second: return "2nd player"
        }
    }
}
