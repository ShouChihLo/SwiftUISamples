//
//  ImageTest.swift
//  HelloWorld(SwiftUI)
//
//  Created by Shou-Chih Lo on 2023/8/28.
//

import SwiftUI

struct ImageTest: View {
    var body: some View {
        Image(systemName: "cloud.heavyrain")
            .font(.system(size: 100))
            .foregroundColor(.blue)
            .shadow(color: .gray, radius: 10, x: 0, y: 10)
        
        Image("photo1_2")
            .resizable()
            //.aspectRatio(contentMode: .fit)
            .scaledToFit()
            .frame(width: 300)
            .clipShape(Circle())
            .opacity(0.8)
            .overlay(
                Text("Hualien").foregroundColor(.white), alignment: .top)
    }
}

struct ImageTest_Previews: PreviewProvider {
    static var previews: some View {
        ImageTest()
    }
}
