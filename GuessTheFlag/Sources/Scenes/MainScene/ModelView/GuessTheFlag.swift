//
//  GuessTheFlag.swift
//  GuessTheFlag
//
//  Created by Джон Костанов on 19/8/23.
//

import SwiftUI

class GuessTheFlag: ObservableObject { 
    @Published var data = DataGame()
    
    
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
            data.showingScore = true
        }
    }
}

