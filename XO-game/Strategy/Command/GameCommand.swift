//
//  GameCommand.swift
//  XO-game
//
//  Created by Aleksandr Derevenskih on 22.12.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

protocol GameCommand {
    func execute()
}

class PutXOCommand: GameCommand {

    let player: Player
    let position: GameboardPosition
    let gameboardView: GameboardView
    let gameboard: Gameboard

    init(player: Player, position: GameboardPosition, gameboardView: GameboardView, gameboard: Gameboard) {
        self.player = player
        self.position = position
        self.gameboardView = gameboardView
        self.gameboard = gameboard
    }

    func execute() {
        if !gameboardView.canPlaceMarkView(at: position) {
            self.gameboardView.removeMarkView(at: position)
        }

        let markView: MarkView
        switch self.player {
        case .first:
            markView = XView()
        case .second:
            markView = OView()
        }

        self.gameboard.setPlayer(self.player, at: position)
        self.gameboardView.placeMarkView(markView, at: position)
    }

}
