//
//  GameState.swift
//  XO-game
//
//  Created by Aleksandr Derevenskih on 21.12.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

protocol GameState {
    var isCompleted: Bool { get }
    var allowInteraction: Bool { get }
    func begin()
    func addMark(at position: GameboardPosition)
}
