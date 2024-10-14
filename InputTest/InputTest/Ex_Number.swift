//
//  Ex_Number.swift
//  InputTest
//
//  Created by 羅壽之 on 2023/8/30.
//

// Note: work only on Xcode 12

import SwiftUI

struct Ex_Number: View {
    @State var age: Int?
    @State var weight: Double?
    
    func RealNumberFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }
    
    var body: some View {
        VStack {
            TextField("Input your age", value: $age, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .padding()
            
            TextField("Input your weight", value: $weight, formatter: RealNumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .padding()
            
            Text("Age: \(age ?? 0)")
            Text(" Weight: \(String(format: "%.2f", weight ?? 0.0))")
        }
    }
}

struct Ex_Number_Previews: PreviewProvider {
    static var previews: some View {
        Ex_Number()
    }
}
