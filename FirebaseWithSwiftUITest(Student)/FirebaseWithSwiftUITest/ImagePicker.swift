//
//  ImagePicker.swift
//  FirebaseWithSwiftUITest
//
//  Created by 羅壽之 on 2024/11/26.
//

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool
    @Binding var selected: UIImage
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let imagePicker = PHPickerViewController(configuration: configuration)
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        private let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            guard let provider = results.first?.itemProvider
            else {
                self.parent.isPresented = false
                return
            }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self)  {
                    image, _ in
                    DispatchQueue.main.async {
                        if let image = image as? UIImage {
                            self.parent.selected = image
                        }
                    }
                }
            }
            
            self.parent.isPresented = false
        }
        
    }
   
    typealias UIViewControllerType = PHPickerViewController
}
