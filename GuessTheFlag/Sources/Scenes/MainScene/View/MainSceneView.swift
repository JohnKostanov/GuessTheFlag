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
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(guessTheFlag.correctAnswerToView)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(guessTheFlag.countriesToView, id: \.self) { country in
                    Button {
                        guessTheFlag.flagTapped(country)
                    } label: {
                        Image(country)
                    }
                }
                
                Text("Score is \(guessTheFlag.data.score)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
                Spacer()
            }
            .onAppear {
                guessTheFlag.startGame()
            }
            .alert(isPresented: $guessTheFlag.data.showingScore) {
                Alert(title: Text(guessTheFlag.data.scoreTitle), message: Text("Your score is \(guessTheFlag.data.score)"), dismissButton: .default(Text("Continue")) {
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
