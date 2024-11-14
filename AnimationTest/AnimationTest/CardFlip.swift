//
//  CardFlip.swift
//  AnimationTest
//
//  Created by Shou-Chih Lo on 2024/11/13.
//

import SwiftUI

struct CardFlip: View {
    @State var isFlipped: Bool = false
    
    var body: some View {
        Image(isFlipped ? "poker_back" : "queen_of_spades")
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 300)
            .rotation3DEffect(
                .degrees(isFlipped ? 180 : 0),
                axis: (x: 0, y: 1, z: 0)
            )
            .onTapGesture {
                withAnimation(.easeInOut) {
                    isFlipped.toggle()
                }
            }
    }
}

struct CardFlip_Previews: PreviewProvider {
    static var previews: some View {
        CardFlip()
    }
}
