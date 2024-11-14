//
//  ContentView.swift
//  AnimationTest
//
//  Created by 羅壽之 on 2023/4/6.
//

import SwiftUI

struct ContentView: View {
    @State var offset: CGFloat = -150  // move left
    @State var isRotating = false
    @State var isShowing = false

    var body: some View {
        
        // using animation
        Image(systemName: "bicycle")
            .font(.largeTitle)
            .offset(x: offset)
            .animation(.easeIn, value: offset)
            .onTapGesture {
               offset += 50 // move right
            }
        
        // group animation
        VStack {
            Image(systemName: "airplane.circle")
            .resizable()
            .frame(width: 50, height: 50)
            .rotationEffect(.degrees(isRotating ? 90 : -90))
           
            Image(systemName: "airplane.circle")
            .resizable()
            .frame(width: 50, height: 50)
            .scaleEffect(isShowing ? 1 : 1.5)
        }
        .animation(.linear, value: isShowing)
        .onTapGesture {
                isRotating.toggle()
                isShowing.toggle()
        }
        
        
       // Using withAnimation
        Image(systemName: "airplane.circle")
        .resizable()
        .frame(width: 50, height: 50)
        .rotationEffect(.degrees(isRotating ? 90 : -90))
        .scaleEffect(isRotating ? 1 : 1.5)
        .onTapGesture {
            withAnimation(.linear) {
                isRotating.toggle()
            }
        }

        // Transition animation
        VStack {
            Group {
                if isShowing {
                    Text("Hello")
                }
                else {
                    Text("World")
                }
            }
            .font(.system(size: 80))
            .foregroundColor(.red)
            .transition(.slide)
            
            Button("Tap me") {
                withAnimation(Animation.linear(duration: 1.0)) {
                    isShowing.toggle()
                }
            }
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
