//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Arjun on 2021-04-24.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var score = 0
    @State private var animationAmount = 0.0
    @State private var opaque = 1.0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
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
                        
                    }) {
                        if number == correctAnswer {
                            Image(self.countries[correctAnswer])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                
                                
                                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                                
                                .shadow(color: .black, radius: 2)
                                .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
                        } else {
                            Image(self.countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                
                                
                                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                                
                                .shadow(color: .black, radius: 2)
                                //.opacity(Double(0.25 * opaque))
                               
                        }
                    }
                }
                
                
                
                Text("Your score is \(score)")
                    .foregroundColor(.white)
                    .font(.headline)
                    .fontWeight(.bold)
                
                
                Spacer()
                
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        withAnimation {
            if number == correctAnswer {
                Image(self.countries[number])
                    .animation(.easeIn)
                    .opacity((Double(0.25 * opaque)))
                
                self.animationAmount += 360
                scoreTitle = "Correct"
                score += 1
                
            } else {
                
                scoreTitle = "Wrong! That's the flag of \(countries[number])"
                score -= 1
                self.animationAmount += 0
                
                
            }
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
        }
    }
}

