//
//  CounterDemo_SwiftUI_App.swift
//  CounterDemo(SwiftUI)
//
//  Created by 羅壽之 on 2023/1/10.
//

import SwiftUI

@main
struct CounterDemo_SwiftUI_App: App {
    @StateObject var viewModel = CounterViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
