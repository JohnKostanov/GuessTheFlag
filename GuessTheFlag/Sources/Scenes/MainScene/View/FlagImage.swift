//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Джон Костанов on 10/8/22.
//

import SwiftUI

struct FlagImage: View {
    
    @Binding var animationAmount: Double
    @Binding var opacityValue: Double
    var country: String
    var correctAnswer: Bool
    
    var body: some View {
        if correctAnswer {
            ImageContent(country: country)
                .rotation3DEffect(.degrees(animationAmount), axis: (x: 1, y: 0, z: 0))
        } else {
            ImageContent(country: country)
                .opacity(opacityValue).animation(.easeInOut(duration: 1), value: opacityValue)
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
