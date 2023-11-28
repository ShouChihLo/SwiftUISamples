//
//  ContentView.swift
//  PhotoPicker(UI)
//
//  Created by 羅壽之 on 2023/3/29.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    @State var showPicker = false
    @State var selectedItem: PhotosPickerItem?
    @State var selectedImage: UIImage = UIImage()
    
    var body: some View {
    
        VStack {
            Button("Select one photo") {
                showPicker.toggle()
            }
            .padding(.bottom, 20)
            .sheet(isPresented: $showPicker) {
                ImagePicker(isPresented: $showPicker, selected: $selectedImage)
            }
            
            Image(uiImage: selectedImage)
                .resizable()
                .scaledToFit()
            
            Spacer()
        }
        
        // ios16+
//        VStack {
//            PhotosPicker("Select on photo", selection: $selectedItem, matching: .images)
//                .padding()
//                        
//            Image(uiImage: selectedImage)
//                .resizable()
//                .scaledToFit()
//                    
//            Spacer()
//        }
//        .onChange(of: selectedItem) { _ in
//            Task {
//                if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
//                    if let image = UIImage(data: data) {
//                        selectedImage = image
//                    }
//                }
//            }
//        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
