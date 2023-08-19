//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Джон Костанов on 15/7/21.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State var animationAmount = 0.0
    @State var opacityValue = 1.0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        if correctAnswer == number {
                            withAnimation {
                                animationAmount += 360
                            }
                        }
                        opacityValue = 0.2
                        
                    }) {
                        FlagImage(animationAmount: $animationAmount,
                                  opacityValue: $opacityValue,
                                  country: self.countries[number],
                                  correctAnswer: correctAnswer == number ? true : false)
                    }
                }
                
                
                Text("Score is \(score)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
                Spacer()
            }
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
            if score > 0 {
                score -= 1
            }
        }
        
        switch number {
        case 0:
            scoreTitle += "\n This is country name: \(countries[0])"
        case 1:
            scoreTitle += "\n This is country name: \(countries[1])"
        case 2:
            scoreTitle += "\n This is country name: \(countries[2])"
        default:
            break
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            showingScore = true
        }
        
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        opacityValue = 1.0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
