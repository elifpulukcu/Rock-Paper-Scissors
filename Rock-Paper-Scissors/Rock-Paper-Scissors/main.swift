//
//  main.swift
//  Rock-Paper-Scissors
//
//  Created by Elif Pulukçu on 18.06.2023.
//

import Foundation

enum Selection: String, CaseIterable {
    case rock = "R"
    case paper = "P"
    case scissors = "S"

    var emoji: String {
        switch self {
        case .rock:
            return "🪨"
        case .paper:
            return "📄"
        case .scissors:
            return "✂️"
        }
    }
}

let scoreEmojis = ["0️⃣", "1️⃣", "2️⃣", "3️⃣"]

func getComputerChoice() -> Selection {
    let choices = Selection.allCases
    let randomChoice = choices[Int(arc4random_uniform(UInt32(choices.count)))]
    return randomChoice
}

func getUserChoice() -> Selection? {
    print("Please make a choice (R, P, or S):")
    if let userChoice = readLine()?.uppercased() {
        switch userChoice {
        case "R":
            return .rock
        case "P":
            return .paper
        case "S":
            return .scissors
        default:
            return nil
        }
    }
    return nil
}

func decideWinner(userChoice: Selection, computerChoice: Selection) -> String {
    print("\nYour choice: \(userChoice.emoji)\nComputer's choice: \(computerChoice.emoji)")
    
    switch (userChoice, computerChoice) {
    case (let choice, let computerChoice) where choice == computerChoice:
        return "draw"
    case (.rock, .scissors), (.paper, .rock), (.scissors, .paper):
        return "user"
    default:
        return "computer"
    }
}

var gameNumber = 1

func playGame() -> Bool {
    var userScore = 0
    var computerScore = 0

    for round in 1...3 {
        print("GAME \(gameNumber) - ROUND \(round)")
        if let userChoice = getUserChoice() {
            let computerChoice = getComputerChoice()
            let winner = decideWinner(userChoice: userChoice, computerChoice: computerChoice)
            if winner == "user" {
                userScore += 1
            } else if winner == "computer" {
                computerScore += 1
            }
            print("\nCURRENT SCORE\nUser: \(scoreEmojis[userScore])\nComputer: \(scoreEmojis[computerScore])\n")
        } else {
            print("Invalid selection, please try again.")
        }
        if round != 3 {
            print("-------------------")
        }
    }

    if userScore > computerScore {
        print("You won the game!")
    } else if computerScore > userScore {
        print("Computer won the game!")
    } else {
        print("The game is a draw!")
    }

    print("Would you like to play again? (Y/N)")
    if let userInput = readLine()?.uppercased() {
        if userInput == "N" {
            return false
        } else if userInput != "Y" {
            print("Invalid input. Please input Y or N.")
            return false
        }
    }
    gameNumber += 1
    return true
}

while playGame() {}
