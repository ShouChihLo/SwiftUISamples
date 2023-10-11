//
//  CounterViewModel.swift
//  CounterDemo(SwiftUI)
//
//  Created by 羅壽之 on 2023/8/29.
//

import Foundation

class CounterViewModel: ObservableObject {
    
    @Published var counter: Int = 0
    
    func increaseCounter() {
        counter += 1
    }
}
