//
//  AboutView.swift
//  Todolist
//
//  Created by Abdelrahman Elkholy on 12/8/20.
//

import SwiftUI

struct AboutView: View {
    let beige = Color(red: 255.0 / 255.0, green: 214.0/255.0, blue: 179.0 / 255.0)
    
    struct Heading : ViewModifier {
        func body(content: Content) -> some View {
                content
                    .foregroundColor(Color.black)
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                    .font(Font.custom("Arial Rounded MT Bold", size: 30))
            }
    }
    
    struct bodyStyle : ViewModifier {
        func body(content: Content) -> some View {
                content
                    .foregroundColor(Color.black)
                    .padding(.leading, 60)
                    .padding(.trailing, 60)
                    
                    .padding(.bottom, 20)
                    .font(Font.custom("Arial Rounded MT Bold", size: 16))
            }
    }
    
    
    var body: some View {
        Group{
        VStack{
            Spacer()

            Text("🎯 SharpEye! 🎯")
                .modifier(Heading())

            Text("This a game where you can win points by dragging the slider.").modifier(bodyStyle())
        

            Text("Just try to place the slider as close as possible to the target value. The closer your are, the more points you score.").multilineTextAlignment(.center).modifier(bodyStyle())
            Text("Play it with your friends and enjoy!").multilineTextAlignment(.center).modifier(bodyStyle())
            Spacer()

            
        }
        .navigationBarTitle("About")
        .background(beige)
        }.background(Image("Background"))
        .padding(.top, 20)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 416))
    }
}
