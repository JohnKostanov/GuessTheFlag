//
//  MainSceneView.swift
//  GuessTheFlag
//
//  Created by Джон Костанов on 15/7/21.
//

import SwiftUI

struct MainSceneView: View {
    
    @StateObject private var guessTheFlag = GuessTheFlag()
    
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
                    Text(guessTheFlag.data.countries[guessTheFlag.data.correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        if guessTheFlag.data.correctAnswer == number {
                            withAnimation {
                                animationAmount += 360
                            }
                        }
                        opacityValue = 0.2
                        
                    }) {
                        FlagImage(animationAmount: $animationAmount,
                                  opacityValue: $opacityValue,
                                  country: guessTheFlag.data.countries[number],
                                  correctAnswer: guessTheFlag.data.correctAnswer == number ? true : false)
                    }
                }
                
                
                Text("Score is \(guessTheFlag.data.score)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
                Spacer()
            }
            .alert(isPresented: $guessTheFlag.data.showingScore) {
                Alert(title: Text(guessTheFlag.data.scoreTitle), message: Text("Your score is \(guessTheFlag.data.score)"), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == guessTheFlag.data.correctAnswer {
            guessTheFlag.data.scoreTitle = "Correct"
            guessTheFlag.data.score += 1
        } else {
            guessTheFlag.data.scoreTitle = "Wrong"
            if guessTheFlag.data.score > 0 {
                guessTheFlag.data.score -= 1
            }
        }
        
        switch number {
        case 0:
            guessTheFlag.data.scoreTitle += "\n This is country name: \(guessTheFlag.data.countries[0])"
        case 1:
            guessTheFlag.data.scoreTitle += "\n This is country name: \(guessTheFlag.data.countries[1])"
        case 2:
            guessTheFlag.data.scoreTitle += "\n This is country name: \(guessTheFlag.data.countries[2])"
        default:
            break
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            guessTheFlag.data.showingScore = true
        }
        
    }
    func askQuestion() {
        guessTheFlag.data.countries.shuffle()
        guessTheFlag.data.correctAnswer = Int.random(in: 0...2)
        opacityValue = 1.0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainSceneView()
    }
}
