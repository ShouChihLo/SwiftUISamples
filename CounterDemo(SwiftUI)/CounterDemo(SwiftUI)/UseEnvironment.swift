//
//  UseEnvironment.swift
//  CounterDemo(SwiftUI)
//
//  Created by 羅壽之 on 2024/7/1.
//

import SwiftUI

struct UseEnvironment: View {
    
    var body: some View {
        VStack {
            BuildButtonEnv(bgColor: .green)
               // .environmentObject(CounterViewModel())
            BuildButtonEnv(bgColor: .red)
               // .environmentObject(CounterViewModel())
        }
        // we can push the viewmodel to the VStack hierarchy
       // .environmentObject(viewModel)
        
    }
}

struct UseEnvironment_Previews: PreviewProvider {
    static var previews: some View {
        UseEnvironment()
            .environmentObject(CounterViewModel())
    }
}

struct BuildButtonEnv: View {
    // for accessing an environment object
    @EnvironmentObject var viewModel: CounterViewModel
    
    var bgColor: Color
    
    var body: some View {
        Button {
            viewModel.increaseCounter()
            
        } label: {
            Text("\(viewModel.counter)")
                .font(.system(size: 50))
                .foregroundColor(.white)
                .padding()
            
        }
        .frame(width: 100, height: 100)
        .background(bgColor)
        .cornerRadius(10)
    }
}

