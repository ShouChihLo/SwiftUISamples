//
//  ViewModel.swift
//  FirebaseWithSwiftUITest
//
//  Created by Shou-Chih Lo on 2023/12/5.
//

import Foundation
import Firebase
import FirebaseStorage
import SwiftUI

class ViewModel: ObservableObject {
    @Published var contacts = [Contact]()
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    func loadData() {
        db.collection("contacts").order(by: "name").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.contacts = documents.map { queryDocumentSnapshot -> Contact in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let name = data["name"] as? String
                let phone = data["phone"] as? String
                let photoPath = data["photoPath"] as? String
                return Contact(id: id, name: name, phone: phone, photoPath: photoPath)
            }
        }
    }
    
    func addData(name: String, phone: String, photo: UIImage) {
        // add a new document
        let newDoc = db.collection("contacts").addDocument(data: [ "name": name, "phone": phone, "photoPath": ""]) { error in
            if let error = error {
                print("Error adding document: \(error)")
            }
        }
        
        // save the photo to the fire storage
        let fileRef = storage.reference().child("contacts/\(newDoc.documentID)_headshot")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        fileRef.putData(photo.jpegData(compressionQuality: 0.5)!, metadata: metadata) { _, error in
            if let error = error {
                print("Error saving image: \(error)")
            }
            else {
                // save the downloadURL
                fileRef.downloadURL { url, error in
                    if let error = error {
                        print("Error getting download url: \(error)")
                    }
                    else if let downloadUrl = url {
                        // update the photoPath
                        newDoc.updateData(["photoPath": downloadUrl.absoluteString]) { error in
                            if let error = error {
                                print("Error updating document: \(error)")
                            }
                        }
                    }
                }
            }
        }
    }
    
   
    func deleteData(docID: String, photoPath: String?) {
        // delete the photo first
        if let path = photoPath {
            let fileRef = storage.reference(forURL: path)
            fileRef.delete { error in
                if let error = error {
                    print("Error deleting file: \(error)")
                }
            }
        }
        
        // delete the document
        db.collection("contacts").document(docID).delete() { error in
            if let error = error {
                print("Error deleting document: \(error)")
            }
        }
    }
}
