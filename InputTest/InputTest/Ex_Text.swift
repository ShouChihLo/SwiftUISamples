//
//  Ex_Text.swift
//  InputTest
//
//  Created by 羅壽之 on 2023/8/30.
//

import SwiftUI

struct Ex_Text: View {
    @State var name: String = ""
    @State var note: String = ""
    
    var body: some View {
        VStack {
            TextField("Input your name", text: $name)
                .font(.headline)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.namePhonePad)
                .textContentType(.name)
                .padding()
            
            TextEditor(text: $note)
                .frame(height: 100)
                .border(Color.gray, width: 1)
                .padding()
            
            Text("Name: \(name)")
            Text("Note: \(note)")
        }
//        let _ = print(name)
//        let _ = print(note)
    }
    
}

struct Ex_Text_Previews: PreviewProvider {
    static var previews: some View {
        Ex_Text()
    }
}
