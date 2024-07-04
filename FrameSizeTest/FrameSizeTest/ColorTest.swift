//
//  ColorTest.swift
//  FrameSizeTest
//
//  Created by 羅壽之 on 2023/8/28.
//

import SwiftUI

struct ColorTest: View {
    
    let gradient = LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.green]), startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        // color name defined in Assets
        Color("myColor")
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
        
        Text("Hello World")
            .background(
                Capsule()
                    .stroke(lineWidth: 10)
                    .foregroundColor(.blue)
                    .frame(width: 200, height: 100)
            )
        
        Circle().fill(gradient)
        
        Text("Hello")
            .font(.title)
            .background(gradient)
    }
}

struct ColorTest_Previews: PreviewProvider {
    static var previews: some View {
        ColorTest()
            .preferredColorScheme(.light)
    }
}
