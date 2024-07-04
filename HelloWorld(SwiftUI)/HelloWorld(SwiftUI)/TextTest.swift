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
        
        Text("""
A long time ago in a galaxy far, far away....
It is a period of civil war. Rebel spaceships, striking from hidden base, have won their first victory against the evil Galactic Empire.
During the battle, Rebel spies managed to steal secret plans to the Empire’s ultimate weapon, the DEATH STAR, an armored
""")
            .lineSpacing(10.0)
            .multilineTextAlignment(.center)
            .rotation3DEffect(
                .degrees(60),
                axis: (x: 1, y: 0, z: 0))
            .shadow(radius: 2, x: 0, y: 15)
    }
}

struct TextTest_Previews: PreviewProvider {
    static var previews: some View {
        TextTest()
    }
}
