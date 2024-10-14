//
//  ContentView.swift
//  NavigationTest
//
//  Created by 羅壽之 on 2023/3/26.
//

import SwiftUI

struct ContentView: View {
    @State var showHelp = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink(destination: WirelessSetting()) {
                        HStack(spacing: 10) {
                            Image(systemName: "wifi")
                                .foregroundColor(.blue)
                            Text("WiFi")
                        }
                    }
                    HStack(spacing: 10) {
                        Image(systemName: "antenna.radiowaves.left.and.right")
                            .foregroundColor(.green)
                        Text("Cellular")
                    }
                }
                
                Section {
                    HStack(spacing: 10) {
                        Image(systemName: "gear")
                            .foregroundColor(.gray)
                        Text("General")
                    }
                    Button("Help") {
                        showHelp = true
                    }
                    .sheet(isPresented: $showHelp) {
                        HelpPage()
                        //.presentationDetents([.height(200)])
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .font(.system(size: 20))
            .navigationTitle("Setting")
        }
        //  .navigationViewStyle(StackNavigationViewStyle())
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WirelessSetting: View {
    
    var body: some View {
        Text("Show a list of controls")
            .navigationTitle("WiFi")
    }
}

struct HelpPage: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Text("Explain how to do the setting")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Close") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
        }
    }
}

