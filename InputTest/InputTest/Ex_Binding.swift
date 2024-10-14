//
//  Ex_Binding.swift
//  InputTest
//
//  Created by 羅壽之 on 2024/10/14.
//

import SwiftUI

struct Ex_Binding: View {
    @State var isSwitchOn: Bool = false
    @State var myControlStruct = HomeControlStruct()
    @StateObject var myControlClass = HomeControlClass()
    
    var body: some View {
        // Binding to a state variable
        VStack {
            Image(systemName: "lightbulb.fill")
                .font(.system(size: 100))
                .foregroundColor(isSwitchOn ? .yellow : .black)
            
            Toggle("Power1", isOn: $isSwitchOn)
                .frame(width: 200)
                .padding()
        }
        
        // Binding to the property of a struct instance
        VStack {
            Image(systemName: "lightbulb.fill")
                .font(.system(size: 100))
                .foregroundColor(myControlStruct.isSwitchOn ? .yellow : .black)
            
            Toggle("Power2", isOn: $myControlStruct.isSwitchOn)
                .frame(width: 200)
                .padding()
        }
        
        // Binding to the property of a class object
        VStack {
            Image(systemName: "lightbulb.fill")
                .font(.system(size: 100))
                .foregroundColor(myControlClass.isSwitchOn ? .yellow : .black)
            
            Toggle("Power3", isOn: $myControlClass.isSwitchOn)
                .frame(width: 200)
                .padding()
        }
        
        // Binding to the whole struct instance
        MyView1(myControl: $myControlStruct)
        
        // Binding to the whole class object
        MyView2(myControl: myControlClass)

    }
}

struct HomeControlStruct {
    var location: String = "Living Room"
    var isSwitchOn: Bool = false
}

class HomeControlClass: ObservableObject {
    var location: String = "Living Room"
    @Published var isSwitchOn: Bool = false
}

struct MyView1: View {
    @Binding var myControl: HomeControlStruct
    
    var body: some View {
        VStack {
            Image(systemName: "lightbulb.fill")
                .font(.system(size: 100))
                .foregroundColor(myControl.isSwitchOn ? .yellow : .black)
            
            Toggle("Power4", isOn: $myControl.isSwitchOn)
                .frame(width: 200)
                .padding()
        }
    }
}

struct MyView2: View {
    @ObservedObject var myControl: HomeControlClass
    
    var body: some View {
        VStack {
            Image(systemName: "lightbulb.fill")
                .font(.system(size: 100))
                .foregroundColor(myControl.isSwitchOn ? .yellow : .black)
            
            Toggle("Power5", isOn: $myControl.isSwitchOn)
                .frame(width: 200)
                .padding()
        }
    }
}


struct Ex_Binding_Previews: PreviewProvider {
    static var previews: some View {
        Ex_Binding()
    }
}
