//
//  ContentView.swift
//  HelloWorld(SwiftUI)
//
//  Created by 羅壽之 on 2023/1/7.
//

import SwiftUI

struct ContentView: View {
    // declare a state variable
    @State private var isPress = false
    
    var body: some View {
        Button {
            // action codes
            isPress = true
        } label: {
            // appearance
            Text("Hello World")
                // use system fonts
                //.font(.system(size: 25))
                // use custom fonts
                .font(.custom("DancingScript-Regular", size: 25))
        }
        .padding()
        .background(Color.purple)
        .foregroundColor(.white)
        .cornerRadius(20)
        // display alert messages
        .alert(isPresented: $isPress, content: {
            Alert(title: Text("Welcome to My First App"), message: Text("Hello World"), dismissButton: .default(Text("OK")))
        })
    }
     
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
