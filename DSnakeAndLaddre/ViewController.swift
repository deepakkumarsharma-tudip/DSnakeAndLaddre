//
//  ViewController.swift
//  DSnakeAndLaddre
//
//  Created by Tudip Technology MM - 00 on 03/09/16.
//  Copyright © 2016 Tudip Technology MM - 00. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var currentLocationLabel: UILabel!

    let player = DSSnakeAndLadderPlayer(name: "Deepak")

    override func viewDidLoad() {
        super.viewDidLoad()
        player.delegate = self
        currentLocationLabel.text = player.currentLocationString
    }

    @IBAction func rollDice(sender: AnyObject) {
        messageLabel.text = ""
        player.rollDice()
    }
}

extension ViewController: DSSnakeAndLadderDelegate {
    func locationChanged(player: DSSnakeAndLadderPlayer, location: Int) {
        currentLocationLabel.text = player.currentLocationString
    }
    func gotBonus(player: DSSnakeAndLadderPlayer, bonus: Int) {
        let message: String = {
            if bonus > 0 {
                messageLabel.textColor = UIColor.greenColor()
                return "Got ladder🚀 😊"
            } else if bonus < 0 {
                messageLabel.textColor = UIColor.redColor()
                return "Biten by snake🐍 😞"
            }
            messageLabel.textColor = UIColor.blackColor()
            return ""
            }()
        messageLabel.text = message
    }
}