//
//  ButtonTest.swift
//  FrameSizeTest
//
//  Created by 羅壽之 on 2023/8/28.
//

import SwiftUI

struct ButtonTest: View {
    var body: some View {
        Button {
           // action codes
        } label: {
            HStack {
                Image(systemName: "trash")
                    .font(.title)
                Text("Delete")
                    // custom view modifier
                    .modifier(MyTextTitle())
            }
        }
        // custom button style
        .buttonStyle(MyButtonStyle())
    }
}

struct MyTextTitle: ViewModifier {
    
    // An alternative way to set the font style
    let myFont = Font.system(.title).weight(.semibold)
    
    func body(content: Content) -> some View {
        content
            .font(myFont)
            // xcode 12 does not support font weight
            //.fontWeight(.semibold)
    }
}

struct MyButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(40)
            // kind of animations
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
    
}

struct ButtonTest_Previews: PreviewProvider {
    static var previews: some View {
        ButtonTest()
    }
}
