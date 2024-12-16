//
//  FormValidationApp.swift
//  FormValidation
//
//  Created by 羅壽之 on 2023/4/27.
//

import SwiftUI
import Firebase

@main
struct FormValidationApp: App {
    @StateObject var accountModel = AccountModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(accountModel)
        }
    }
}
