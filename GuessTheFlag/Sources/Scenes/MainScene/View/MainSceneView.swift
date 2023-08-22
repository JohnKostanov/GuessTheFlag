//
//  MainSceneView.swift
//  GuessTheFlag
//
//  Created by Джон Костанов on 15/7/21.
//

import SwiftUI

struct MainSceneView: View {
    
    @StateObject private var guessTheFlag = GuessTheFlag()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                Spacer()
                VStack {
                    Text("Tap the flag of")
                    Text(guessTheFlag.correctAnswerToView)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                .foregroundColor(.white)
                Spacer()
                ForEach(guessTheFlag.countriesToView, id: \.self) { country in
                    Button {
                        guessTheFlag.flagTapped(country)
                    } label: {
                        FlagImage(guessTheFlag: guessTheFlag,
                                  country: country,
                                  isCorrectAnswer: country == guessTheFlag.correctAnswerToView)
                    }
                    .disabled(guessTheFlag.isFlagTapped)
                }
                Spacer()
                Text("Score is \(guessTheFlag.data.score)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
                Spacer()
            }
            .onAppear {
                guessTheFlag.startGame()
            }
            .alert(isPresented: $guessTheFlag.showingScore) {
                Alert(title: Text(guessTheFlag.scoreTitle), message: Text("Your score is \(guessTheFlag.data.score)"), dismissButton: .default(Text("Continue")) {
                    guessTheFlag.askQuestion()
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainSceneView()
    }
}
