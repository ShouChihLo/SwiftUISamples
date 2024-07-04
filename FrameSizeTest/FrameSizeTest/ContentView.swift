//
//  ContentView.swift
//  FrameSizeTest
//
//  Created by 羅壽之 on 2023/4/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        // Equally sizing
        VStack(spacing: 0) {
            Color.blue
                // whole screen size
                .frame(minWidth: 0, maxWidth: .infinity,
                       minHeight: 0, maxHeight: .infinity)
            Color.green
                // whole screen size
                .frame(minWidth: 0, maxWidth: .infinity,
                       minHeight: 0, maxHeight: .infinity)
        }
        // We can set the size of the VStack
        //.frame(width: 200, height: 200)
        
        // Proportionally sizing
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Color.blue
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: geometry.size.height*1/3)
                Color.green
                    .frame(minWidth: 0, maxWidth:.infinity)
                    .frame(height: geometry.size.height*2/3)
            }
            
        }
        // GeometryReader will read the size of the parent view of the VStack
        // Here, we can the set the size to the parent view
        //.frame(width: 200, height: 200)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
