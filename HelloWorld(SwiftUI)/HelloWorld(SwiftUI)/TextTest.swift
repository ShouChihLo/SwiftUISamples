//
//  TextTest.swift
//  HelloWorld(SwiftUI)
//
//  Created by Shou-Chih Lo on 2023/8/28.
//

import SwiftUI

struct TextTest: View {
    var body: some View {
        Text("Hello, World!")
            .fontWeight(.bold)
            .font(.title)
            .foregroundColor(.yellow)
            .background(Color.blue)
            .padding()
            .shadow(radius: 2, x: 0, y: 15)
    }
}

struct TextTest_Previews: PreviewProvider {
    static var previews: some View {
        TextTest()
    }
}
