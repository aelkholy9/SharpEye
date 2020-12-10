//
//  ContentView.swift
//  Todolist
//
//  Created by Abdelrahman Elkholy on 12/2/20.
//

import SwiftUI

struct ContentView: View {
    
    struct LabelStyle: ViewModifier { // men el akher da zy el main theme kda fe flutter
        
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
                .font(Font.custom("Arial Rounded MT BOLD", size: 18))
                .modifier(Shadow())
        }
    }
    
    struct ValueStyle : ViewModifier {
        func body(content: Content) -> some View {
                return content
                    .foregroundColor(Color.yellow)
                    .modifier(Shadow())
                    .font(Font.custom("Arial Rounded MT Bold", size: 24))

        
    }
    }
    
    struct Shadow : ViewModifier {
        func body(content: Content) -> some View {
                content
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)

    }
    }
    
    struct buttonModifier : ViewModifier {
        func body(content: Content) -> some View {
                content
                .modifier(Shadow())
                .background(Image("Button"))

    }
    }
    
    
    struct ButtonText : ViewModifier {
        func body(content: Content) -> some View {
                return content
                    .foregroundColor(Color.black)
                    .font(Font.custom("Arial Rounded MT Bold", size: 12))

        
    }
    }
    
    
    @State var alertIsVisible: Bool = false
    @State var slideVal: Double = 50.0
    @State var target: Int = Int.random(in: 1...100)
    @State var score: Int = 0
    @State var round = 1
    func calculateScoreRound () -> Int {
        let maxScore = 100
        let diff = amountOff()
        let bonus : Int
        if diff == 0 {
            bonus = 100
        }
        else if diff == 1 {
            bonus = 50
        }
        else {
            bonus = 0
        }
        
        return maxScore - diff + bonus
    }
    
    func roundSlideVal () -> Int {
        Int(slideVal.rounded())
    }
    
    func amountOff () -> Int {
        abs(target-roundSlideVal())
    }
    func alertTitle () -> String {
        let diff = amountOff()
        if diff == 0 {
            return "Perfect!"
        }
        else if diff < 7 {
            return "Too Close!"
        }
        else {
            return "Too Far :("
        }
    }
    
    
    func resetGame() {
        score = 0
        round = 1
        slideVal = 50.0
        target = Int.random(in: 1...100)
    }
    
    var body: some View {
        VStack {
            Spacer()
            //target row
            HStack {
                Text("Drag the slider as close as you can to: ").modifier(LabelStyle())
                    
                Text("\(target)").modifier(ValueStyle())
            }
            Spacer()
            //slider row
            HStack{
                Text("1").modifier(ValueStyle())
                Slider(value: $slideVal, in: 1...100).accentColor(Color.yellow)
                Text("100").modifier(ValueStyle())
            }
            Spacer()
            //button row
            Button(action: {
               
               alertIsVisible = true
                
            }) {
                Text("Hit Me!").modifier(ButtonText())
                    
            }
            .alert(isPresented: $alertIsVisible,  content: {
                let roundedVal = roundSlideVal()
                return Alert(title: Text(alertTitle()), message: Text("The slider's value is \(roundedVal)\n" + "You scored \(calculateScoreRound())" ), dismissButton: .default(Text("Awesome!")){
                    
                    score += calculateScoreRound()
                    target = Int.random(in: 1...100)
                    round += 1
                })
            })
            .modifier(buttonModifier())
            Spacer()
            // info row
            HStack{
                Button(action: {resetGame()}) {
                    HStack{
                        Image("StartOverIcon")
                        Text("Start over").modifier(ButtonText())

                    }
                }
                .modifier(buttonModifier())

                Spacer()
                Text("Score: ").modifier(LabelStyle())
                Text("\(score)").modifier(ValueStyle())
                Spacer()
                Text("Round: ").modifier(LabelStyle())
                Text("\(round)").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: AboutView()) {
                    HStack{
                        Image("InfoIcon")
                        Text("Info").modifier(ButtonText())

                    }
                }
                .modifier(buttonModifier())

            }.padding(.bottom, 20)
        }.background(Image("Background"))
        .navigationBarTitle("SharpEye")
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 416))
    }
}
