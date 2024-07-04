//
//  PositionTest.swift
//  FrameSizeTest
//
//  Created by 羅壽之 on 2024/6/17.
//

import SwiftUI

struct PositionTest: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            // relative offset to the center position
           // .offset(x: 100, y: 200)
            
            // absolute position to the top-left corner
            //.position(x: 100, y: 200)
            
            // set a frame size to the Text
            .frame(width: 200, height: 200, alignment: .topTrailing)
        
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                // set the middle position of Text
                .position(x: 0.0, y: 0.0)
        }
        .frame(width: 200,height: 200)
    }
}

struct PositionTest_Previews: PreviewProvider {
    static var previews: some View {
        PositionTest()
    }
}
