//
//  Ex_Toggle.swift
//  InputTest
//
//  Created by 羅壽之 on 2023/8/30.
//

import SwiftUI

struct Ex_Toggle: View {
    @State var isSwitchOn: Bool = false
    
    var body: some View {
        VStack {
            Image(systemName: "lightbulb.fill")
                .font(.system(size: 100))
                .foregroundColor(isSwitchOn ? .yellow : .black)
            
            Toggle("Power", isOn: $isSwitchOn)
                .frame(width: 200)
                .padding()
        }

    }
}

struct Ex_Toggle_Previews: PreviewProvider {
    static var previews: some View {
        Ex_Toggle()
    }
}
