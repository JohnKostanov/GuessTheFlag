//
//  GuessTheFlag.swift
//  GuessTheFlag
//
//  Created by Джон Костанов on 19/8/23.
//

import SwiftUI

class GuessTheFlag: ObservableObject { 
    @Published var data = DataGame()
    @Published var countriesToView = [String]()
    @Published var correctAnswerToView = String()
    
    @Published var showingScore = false
    @Published var scoreTitle = ""
    
    @Published var animationAmount = 0.0
    @Published var opacityValue = 1.0
    
    @Published var isFlagTapped = false
    
    func startGame() {
        countriesToView.removeAll()
        _ = data.countries.publisher
            .prefix(3)
            .sink { [unowned self] (result) in
                countriesToView.append(result)
            }
        countriesToView.shuffled().publisher
            .dropFirst()
            .assign(to: &$correctAnswerToView)
    }
    
    func flagTapped(_ country: String) {
        isFlagTapped = true
        if country == correctAnswerToView {
            scoreTitle = "Correct"
            data.score += 1
            withAnimation {
                animationAmount += 360
            }
        } else {
            scoreTitle = "Wrong"
            if data.score > 0 {
                data.score -= 1
            }
            opacityValue = 0.2
        }
        
        scoreTitle += "\n This is country name: \(country)"
        
        $isFlagTapped
            .delay(for: 1, scheduler: RunLoop.main)
            .assign(to: &$showingScore)
        
    }
    
    func askQuestion() {
        data.countries.shuffle()
        startGame()
        opacityValue = 1.0
        isFlagTapped = false
    }
}

