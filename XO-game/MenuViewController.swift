//
//  MenuViewController.swift
//  XO-game
//
//  Created by Aleksandr Derevenskih on 21.12.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? GameViewController else {
            return
        }
        if segue.identifier == "PvAISegue" {
            destination.configure(strategy: PvAIGameStrategy())
        } else if segue.identifier == "PvP5x5Segue" {
            destination.configure(strategy: PvP5x5GameStrategy())
        } else {
            destination.configure(strategy: PvPGameStrategy())
        }
    }
}
