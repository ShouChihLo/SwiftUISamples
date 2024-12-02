//
//  SImpleCoreDataTextApp.swift
//  SImpleCoreDataText
//
//  Created by 羅壽之 on 2023/4/25.
//

import SwiftUI

@main
struct SimpleCoreDataTestApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.viewContext)
        }
    }
}
