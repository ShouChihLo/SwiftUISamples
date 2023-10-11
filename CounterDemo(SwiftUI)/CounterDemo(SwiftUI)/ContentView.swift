//
//  ContentView.swift
//  CounterDemo(SwiftUI)
//
//  Created by 羅壽之 on 2023/1/10.
//

import SwiftUI

struct ContentView: View {
    //@StateObject var viewModel = CounterViewModel()
    
    var body: some View {
        VStack {
            BuildButton(bgColor: .green)
            BuildButton(bgColor: .red)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CounterViewModel())
    }
}

struct BuildButton: View {
    
    //@ObservedObject var viewModel: CounterViewModel
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
