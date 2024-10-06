//
//  UseStateObject.swift
//  CounterDemo(SwiftUI)
//
//  Created by 羅壽之 on 2024/7/1.
//

import SwiftUI

struct UseStateObject: View {
    
    // declare and create a viewmodel
    @StateObject var viewModel = CounterViewModel()
    
    var body: some View {
        VStack {
            BuildButtonObject(viewModel: viewModel, bgColor: .green)
            BuildButtonObject(viewModel: viewModel, bgColor: .red)
        }
    }
}

struct UseStateObject_Previews: PreviewProvider {
    static var previews: some View {
        UseStateObject()
    }
}

struct BuildButtonObject: View {
    
    // for accessing a passed stateobject
    @ObservedObject var viewModel: CounterViewModel
        
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

