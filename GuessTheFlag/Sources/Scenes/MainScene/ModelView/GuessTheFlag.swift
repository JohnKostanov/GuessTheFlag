//
//  GuessTheFlag.swift
//  GuessTheFlag
//
//  Created by Джон Костанов on 19/8/23.
//

import SwiftUI
//import Combine

class GuessTheFlag: ObservableObject { 
    @Published var data = DataGame()
    @Published var countriesToView = [String]()
    @Published var correctAnswerToView = String()
    
    @Published var animationAmount = 0.0
    @Published var opacityValue = 1.0
    
    func startGame() {
        countriesToView.removeAll()
        _ = data.countries.publisher
            .prefix(3)
            .sink { [unowned self] (result) in
                countriesToView.append(result)
            }
        correctAnswerToView = countriesToView.randomElement() ?? ""
    }
    
    func flagTapped(_ country: String) {
        if country == correctAnswerToView {
            data.scoreTitle = "Correct"
            data.score += 1
            withAnimation {
                animationAmount += 360
            }
        } else {
            data.scoreTitle = "Wrong"
            if data.score > 0 {
                data.score -= 1
            }
            withAnimation {
                opacityValue = 0.2
            }
        }
        
        data.scoreTitle += "\n This is country name: \(country)"
        
        data.showingScore = true
    }
    
    func askQuestion() {
        data.countries.shuffle()
        startGame()
        opacityValue = 1.0
    }
}

