//
//  ContentView.swift
//  GestureTest
//
//  Created by 羅壽之 on 2023/4/10.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPressed = false
    @State private var position = CGPoint(x: 50, y: 50)
    @State private var scale: CGFloat = 1.0
    @GestureState private var zoomFactor: CGFloat = 1.0
    
    var body: some View {
        
        // TapGesture
        Image(systemName: "heart.fill")
            .font(.system(size: 50))
            .foregroundColor(isPressed ? .blue : .green)
            .onTapGesture {
                isPressed.toggle()
            }
            
        // GragGesture
        let dragGesture = DragGesture()
            .onChanged { value in
                position = value.location
            }
        
        
        Image(systemName: "heart.fill")
            .font(.system(size: 50))
            .foregroundColor(.blue)
            .position(position)
            .gesture(dragGesture)
        
        // MagnificationGesture()
        let magGesture = MagnificationGesture()
            .updating($zoomFactor) { value, level, transaction in
                level = value
            }
            .onEnded { value in
                scale = scale * value
            }
        
        Image("photo2_1")
            .resizable()
            .scaledToFit()
            .frame(width: 100)
            .scaleEffect(scale * zoomFactor)
            .gesture(magGesture)
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
