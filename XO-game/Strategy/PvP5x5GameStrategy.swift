//
//  PvP5x5GameStrategy.swift
//  XO-game
//
//  Created by Aleksandr Derevenskih on 22.12.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

class PvP5x5GameStrategy: GameStrategy {

    var commands: [Player: Queue<GameCommand>] = [ .first: Queue<GameCommand>(), .second: Queue<GameCommand>()]
    var isAutoGamePhase = false

    func initialState(player: Player, gameViewController: GameViewController, gameboard: Gameboard, gameboardView: GameboardView) -> GameState {
        return Player5x5InputState(
            player: .first,
            gameViewController: gameViewController,
            gameboard: gameboard,
            gameboardView: gameboardView)
    }

    func nextState(currentState: GameState, referee: Referee, gameViewController: GameViewController, gameboard: Gameboard, gameboardView: GameboardView) -> GameState? {
        if isAutoGamePhase, let winner = referee.determineWinner() {
            return GameEndedState(winner: winner, gameViewController: gameViewController)
        }

        if let playerInputState = currentState as? Player5x5InputState {
            if playerInputState.player == .first {
                gameboard.clear()
                gameboardView.clear()
                return Player5x5InputState(
                    player: .second,
                    gameViewController: gameViewController,
                    gameboard: gameboard,
                    gameboardView: gameboardView)
            } else if playerInputState.player == .second {
                gameboard.clear()
                gameboardView.clear()

                isAutoGamePhase = true
                return AIInputState(
                    player: .first,
                    gameViewController: gameViewController,
                    gameboard: gameboard,
                    gameboardView: gameboardView)
            }
        } else if let playerInputState = currentState as? AIInputState {
            return AIInputState(
                player: playerInputState.player.next,
                gameViewController: gameViewController,
                gameboard: gameboard,
                gameboardView: gameboardView)
        }

        return nil
    }

    func timerState(currentState: GameState) {
        if isAutoGamePhase {
            if let state = currentState as? AIInputState {
                if !state.isCompleted {
                    let command = commands[state.player]?.dequeue()
                    command?.execute()
                    state.forceComplete()
                }
            }
        }
    }

    func onSelectPosition(state: GameState, at position: GameboardPosition) {
        guard let state = state as? Player5x5InputState else {
            return
        }
        if state.allowInteraction && !state.isCompleted {
            if state.addMark(at: position) {
                if let gameboard = state.gameboard,
                   let gameboardView = state.gameboardView {
                    let command = PutXOCommand(player: state.player, position: position, gameboardView: gameboardView, gameboard: gameboard)
                    commands[state.player]?.push(command)
                }
            }
        }
    }
}
