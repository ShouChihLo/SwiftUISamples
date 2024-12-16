//
//  AccountModel.swift
//  FormValidation
//
//  Created by 羅壽之 on 2024/12/1.
//

import SwiftUI
import FirebaseAuth

class AccountModel: ObservableObject {
    @Published var user: User? = nil
    @Published var isLoggedIn = false

    init() {
        self.user = Auth.auth().currentUser
        self.isLoggedIn = user != nil
    }

    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                print("Failed to sign in: \(error.localizedDescription)")
                return
            }
            self?.user = result?.user
            self?.isLoggedIn = true
        }
    }

    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                print("Failed to sign up: \(error.localizedDescription)")
                return
            }
            self?.user = result?.user
            self?.isLoggedIn = true
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            self.user = nil
            self.isLoggedIn = false
        } catch {
            print("Failed to sign out: \(error.localizedDescription)")
        }
    }
}
