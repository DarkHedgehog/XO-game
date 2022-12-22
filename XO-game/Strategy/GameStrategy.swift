//
//  GameStrategy.swift
//  XO-game
//
//  Created by Aleksandr Derevenskih on 21.12.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

protocol GameStrategy {
    func initialState(player: Player, gameViewController: GameViewController, gameboard: Gameboard, gameboardView: GameboardView) -> GameState
    func nextState(currentState: GameState, referee: Referee, gameViewController: GameViewController, gameboard: Gameboard, gameboardView: GameboardView) -> GameState?
    func timerState(currentState: GameState)
}
