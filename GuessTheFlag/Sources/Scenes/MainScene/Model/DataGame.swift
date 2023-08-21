//
//  DataGame.swift
//  GuessTheFlag
//
//  Created by Джон Костанов on 19/8/23.
//

import Foundation

struct DataGame {
    var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    var correctAnswer = Int.random(in: 0...2)
    var showingScore = false
    var scoreTitle = ""
    var score = 0
}
