//
//  GuessTheFlag.swift
//  GuessTheFlag
//
//  Created by Джон Костанов on 19/8/23.
//

import SwiftUI
import Combine

class GuessTheFlag: ObservableObject { 
    @Published var data = DataGame()
    @Published var countriesToView = [String]()
    
    @Published var animationAmount = 0.0
    @Published var opacityValue = 1.0
    
    init() {
        _ = data.countries.publisher
            .prefix(3)
            .sink { [unowned self] (result) in
                countriesToView.append(result)
            }
    }
    
    func flagTapped(_ number: Int) {
        if number == data.correctAnswer {
            data.scoreTitle = "Correct"
            data.score += 1
        } else {
            data.scoreTitle = "Wrong"
            if data.score > 0 {
                data.score -= 1
            }
        }
        
        switch number {
        case 0:
            data.scoreTitle += "\n This is country name: \(data.countries[0])"
        case 1:
            data.scoreTitle += "\n This is country name: \(data.countries[1])"
        case 2:
            data.scoreTitle += "\n This is country name: \(data.countries[2])"
        default:
            break
        }
        
        if data.correctAnswer == number {
            withAnimation {
                animationAmount += 360
            }
        }
        opacityValue = 0.2
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
            data.showingScore = true
        }
    }
    
    func askQuestion() {
        data.countries.shuffle()
        data.correctAnswer = Int.random(in: 0...2)
        opacityValue = 1.0
    }
}

