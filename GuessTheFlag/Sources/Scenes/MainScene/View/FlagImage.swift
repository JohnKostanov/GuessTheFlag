//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Джон Костанов on 10/8/22.
//

import SwiftUI

struct FlagImage: View {
    
    @ObservedObject var guessTheFlag: GuessTheFlag
    var country: String
    var isCorrectAnswer: Bool
    
    var body: some View {
        if isCorrectAnswer {
            ImageContent(country: country)
                .rotation3DEffect(.degrees(guessTheFlag.animationAmount), axis: (x: 1, y: 0, z: 0))
        } else {
            ImageContent(country: country)
                .opacity(guessTheFlag.opacityValue).animation(.easeInOut(duration: 1),
                                                              value: guessTheFlag.opacityValue)
        }
    }
}

struct ImageContent: View {
    var country: String
    
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}
