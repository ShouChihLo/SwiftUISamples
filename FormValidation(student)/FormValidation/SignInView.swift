//
//  SignInView.swift
//  FormValidation
//
//  Created by 羅壽之 on 2024/12/16.
//

import SwiftUI

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var accountModel: AccountModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Email", text: $email)
                        .autocapitalization(.none)
                    
                    SecureField("Password", text: $password)
                }
                
                Button {
                    accountModel.signIn(email: email, password: password)
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Submit")
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(30)
                .padding(.top, 10)
            } // VStack
            .navigationTitle("Sign In")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        } // NavigationView
        
    }
}

