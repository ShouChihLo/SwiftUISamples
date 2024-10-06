//
//  ContentView.swift
//  CounterDemo(SwiftUI)
//
//  Created by 羅壽之 on 2023/1/10.
//

import SwiftUI

struct ContentView: View {
    // Use the basic state variable
    @State var counter = 0
    
    var body: some View {
        VStack {
            BuildButton(counter: $counter, bgColor: .green)
            BuildButton(counter: $counter, bgColor: .red)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct BuildButton: View {
    
    // for accessing a passed state variable
    @Binding var counter: Int
        
    var bgColor: Color
    
    var body: some View {
        Button {
            counter += 1
        } label: {
            Text("\(counter)")
                .font(.system(size: 50))
                .foregroundColor(.white)
                .padding()
        }
        .frame(width: 100, height: 100)
        .background(bgColor)
        .cornerRadius(10)
    }
}
