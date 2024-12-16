//
//  ContentView.swift
//  FormValidation
//
//  Created by 羅壽之 on 2023/4/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView() {
            HomePage()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            CustomPage()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Custom")
                }
        }
    }
}

struct HomePage: View {
    var body: some View {
        Text("Home Page")
            .font(.title)
    }
}

struct CustomPage: View {
    @EnvironmentObject var accountModel: AccountModel
    @State var showSignIn = false
    @State var showSignUp = false
    
    var body: some View {
        VStack {
            Text("Welcome")
                .font(.title)
            if let user = accountModel.user {
                Text("\(user.email ?? "")")
                    .padding()
            }
            else {
                Text("Not logged in")
                    .padding()
            }
            
            // Sign In Button
            Button {
                showSignIn.toggle()
            }
            label: {
                HStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Sign In")
                        .font(.headline)
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(accountModel.user != nil ? Color.gray : Color.blue)
                .cornerRadius(30)
            }
            .disabled(accountModel.user != nil)
            .sheet(isPresented: $showSignIn) {
                SignInView()
            }
            
            // Sign Up Button
            Button {
                showSignUp.toggle()
            } label: {
                HStack {
                    Image(systemName: "person.badge.plus.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Sign Up")
                        .font(.headline)
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(accountModel.user != nil ? Color.gray : Color.green)
                .cornerRadius(30)
            }
            .disabled(accountModel.user != nil)
            .sheet(isPresented: $showSignUp) {
                SignUpView()
            }
            
            // Logout Button
            Button {
                accountModel.signOut()
            } label: {
                HStack {
                    Image(systemName: "arrow.backward.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Logout")
                        .font(.headline)
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(accountModel.user == nil ? Color.gray : Color.red)
                .cornerRadius(30)
            }
            .disabled(accountModel.user == nil)
        } // VStack
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AccountModel())
    }
}
