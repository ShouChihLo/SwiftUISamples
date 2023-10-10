//
//  ContentView.swift
//  StackViewDemo(SwiftUI)
//
//  Created by 羅壽之 on 2023/1/9.
//

import SwiftUI

struct ContentView: View {
    
    // get the vertical size of the screen
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                Text("Instant Developer")
                    .fontWeight(.medium)
                    .font(.system(size: 40))
                    .foregroundColor(.blue)
                
                Text("Get help from experts in 15 minutes")
            }
            
            HStack(alignment: .bottom, spacing: 10) {
                Image("user1")
                    .resizable()
                    .scaledToFit()
                
                Image("user2")
                    .resizable()
                    .scaledToFit()
                
                Image("user3")
                    .resizable()
                    .scaledToFit()
            }
            .padding(.horizontal, 20)
            
            Text("Need help with coding problems? Register!")
            
            Spacer()
            
            // adjust the UI automatically
            if verticalSizeClass == .compact {
                HSignUpButtonGroup()
            }
            else {
                VSignUpButtonGroup()
            }
            
        }
        .padding(.top, 30)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro"))
                .previewDisplayName("iPhone 12 Pro")
            // xcode 13+
            //.previewInterfaceOrientation(.landscapeLeft)
            
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
                .previewDisplayName("iPhone SE")
        }
        
        
    }
}

struct VSignUpButtonGroup: View {
    var body: some View {
        VStack {
            Button {
                
            } label: {
                Text("Sign Up")
            }
            .frame(width: 200)
            .padding()
            .foregroundColor(.white)
            .background(Color.gray)
            .cornerRadius(10)
            
            Button {
                
            } label: {
                Text("Log In")
            }
            .frame(width: 200)
            .padding()
            .foregroundColor(.white)
            .background(Color.gray)
            .cornerRadius(10)
        }
    }
}

struct HSignUpButtonGroup: View {
    var body: some View {
        HStack {
            Button {
                
            } label: {
                Text("Sign Up")
            }
            .frame(width: 200)
            .padding()
            .foregroundColor(.white)
            .background(Color.gray)
            .cornerRadius(10)
            
            Button {
                
            } label: {
                Text("Log In")
            }
            .frame(width: 200)
            .padding()
            .foregroundColor(.white)
            .background(Color.gray)
            .cornerRadius(10)
        }
    }
}

