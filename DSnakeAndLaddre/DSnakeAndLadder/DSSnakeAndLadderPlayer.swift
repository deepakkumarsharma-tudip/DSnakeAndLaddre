//
//  DSSnakeAndLadderPlayer.swift
//  DSnakeAndLaddre
//
//  Created by Tudip Technology MM - 00 on 03/09/16.
//  Copyright © 2016 Tudip Technology MM - 00. All rights reserved.
//

import Foundation

protocol DSSnakeAndLadderDelegate {
    func locationChanged(player: DSSnakeAndLadderPlayer, location: Int)
    func gotBonus(player: DSSnakeAndLadderPlayer, bonus: Int)
}

public class DSSnakeAndLadderPlayer {

    static var winner: String? = nil

    var name: String

    var delegate: DSSnakeAndLadderDelegate?

    init(name: String) {
        self.name = name
        delegate = nil
    }

    var currentLocation: Int = 0 {
        didSet {
            if currentLocation == 100 {
                DSSnakeAndLadderPlayer.winner = name
            }
            currentLocationString = currentLocation == 100 ? "\(name) is Winner..." : "\(name)'s location is \(currentLocation)"
            delegate?.locationChanged(self, location: currentLocation)
        }
    }

    var currentLocationString: String = "Please roll dice to start"

    static let board: [Int] = {
        var array = [Int]()
        (0...100).forEach { number in
            let bonus = DSSnakeAndLadderPlayer.getBonusNumber(number)
            array.append(bonus)
        }
        return array
        }()

    class func getBonusNumber(index: Int) -> Int {
        switch index {
        case 3: return 48
        case 6: return 21
        case 20: return 50
        case 36: return 19
        case 63: return 32
        case 68: return 30
        case 25: return -20
        case 34: return -33
        case 47: return -28
        case 65: return -13
        case 87, 91, 99: return -30
        default: return 0
        }
    }

    var diceOutPut = 0 {
        didSet {
            calculateNewDistance()
        }
    }

    func calculateNewDistance() {
        currentLocation = calculateNewPosition(currentLocation, delta: diceOutPut)
    }

    func calculateNewPosition(current: Int, delta: Int) -> Int {
        if delta != 0 {
            let tempLocation = current + delta
            if tempLocation > 100 {
                return current
            } else {
                let newDelta = DSSnakeAndLadderPlayer.board[tempLocation]
                delegate?.gotBonus(self, bonus: newDelta)
                return tempLocation + newDelta
            }
        }
        return current
    }

    func rollDice() {
        if let winner = DSSnakeAndLadderPlayer.winner {
            let message = winner == name ? "you are Winner..." : "winner is \(winner)"
            print(message)
        } else {
            diceOutPut = Int(arc4random_uniform(6)+1)
            print("Dice output = \(diceOutPut)")
        }
    }
}
