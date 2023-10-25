//
//  CardView.swift
//  ScrollViewTest
//
//  Created by 羅壽之 on 2023/3/28.
//

import SwiftUI

struct CardView: View {
    var image: String
    var name: String
    
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .cornerRadius(20)
                
            Text(name)
        }
        .padding()
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(image:"photo0_0", name:"Tianyuan Temple")
    }
}
