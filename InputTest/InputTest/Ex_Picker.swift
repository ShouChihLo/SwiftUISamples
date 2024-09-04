//
//  Ex_Picker.swift
//  InputTest
//
//  Created by 羅壽之 on 2023/8/30.
//

import SwiftUI

struct Ex_Picker: View {
    
    let bloods = ["A", "B", "O", "AB"]
    @State var selectionIndex = 0
    @State var birthday = Date()
    @State var frequency = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("Blood Tye:")
                Picker(selection: $selectionIndex, label: Text("Type")) {
                    ForEach(bloods.indices, id:\.self) { index in
                        Text(bloods[index])
                    }
                }
              //  .pickerStyle(SegmentedPickerStyle())
                .pickerStyle(MenuPickerStyle())
               // .pickerStyle(WheelPickerStyle())
                .padding()
            }
            
            DatePicker("Pick up", selection: $birthday, displayedComponents: .date)
                .labelsHidden()
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
            
            Stepper("Every \(frequency) days", value: $frequency, in: 0...7)
                .padding()
        }
    }
}

struct Ex_Picker_Previews: PreviewProvider {
    static var previews: some View {
        Ex_Picker()
    }
}
