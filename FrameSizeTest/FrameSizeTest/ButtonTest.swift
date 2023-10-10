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
                    .modifier(MyTextTitle())
            }
        }
        .buttonStyle(MyButtonStyle())
    }
}

struct MyTextTitle: ViewModifier {
    
    let myFont = Font.system(.title).weight(.semibold)
    
    func body(content: Content) -> some View {
        content
            .font(myFont)
    }
}

struct MyButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(40)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
    
}

struct ButtonTest_Previews: PreviewProvider {
    static var previews: some View {
        ButtonTest()
    }
}
