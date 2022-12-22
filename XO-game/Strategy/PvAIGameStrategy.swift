//
//  PvAIGameStrategy.swift
//  XO-game
//
//  Created by Aleksandr Derevenskih on 21.12.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

class PvAIGameStrategy: GameStrategy {
    func initialState(player: Player, gameViewController: GameViewController, gameboard: Gameboard, gameboardView: GameboardView) -> GameState {
        return PlayerInputState(
            player: player,
            gameViewController: gameViewController,
            gameboard: gameboard,
            gameboardView: gameboardView)
    }

    func nextState(currentState: GameState, referee: Referee, gameViewController: GameViewController, gameboard: Gameboard, gameboardView: GameboardView) -> GameState? {
        if let winner = referee.determineWinner() {
            return GameEndedState(winner: winner, gameViewController: gameViewController)
        }
        if let playerInputState = currentState as? PlayerInputState {
            return AIInputState(
                player: .second,
                gameViewController: gameViewController,
                gameboard: gameboard,
                gameboardView: gameboardView)
        } else if let playerInputState = currentState as? AIInputState {
            return PlayerInputState(
                player: .first,
                gameViewController: gameViewController,
                gameboard: gameboard,
                gameboardView: gameboardView)
        }

        return nil
    }
    func timerState(currentState: GameState) {
        if let aiInputState = currentState as? AIInputState {
            aiInputState.addRandomMark()
        }
    }
}
