//
//  ContentView.swift
//  InputTest
//
//  Created by 羅壽之 on 2023/3/23.
//

// Demo: Form

import SwiftUI

struct ContentView: View {
    
    @State var personProfile = Profile()
    
    var bloods = ["A", "B", "O", "AB"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Input your name", text: $personProfile.name)
                        .textFieldStyle(PlainTextFieldStyle())
                }
                
                Section(header: Text("Blood")) {
                    
                    Picker(selection: $personProfile.bloodIndex, label: Text("Type")) {
                        ForEach(bloods.indices, id:\.self) { index in
                            Text(bloods[index])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Birthday")) {
                    DatePicker("Select", selection: $personProfile.birthday, displayedComponents: .date)
                }
                
                Section(header: Text("Exercises")) {
                    Stepper("\(personProfile.frequency) times per week", value: $personProfile.frequency, in: 0...7)
                }
                Section(header: Text("Smoke")) {
                    Toggle("Smoke", isOn: $personProfile.smoke)
                       .labelsHidden()
                }
            } // Form
        
            .navigationTitle("Profile")
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print(personProfile)
                    } label: {
                        Text("Confirm")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        
                    } label: {
                        Text("Cancel")
                    }
                }
            }
            
        } // navigation view
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
