//
//  ViewModel.swift
//  FirebaseWithSwiftUITest
//
//  Created by Shou-Chih Lo on 2023/12/5.
//

import Foundation
import Firebase

class ViewModel: ObservableObject {
    @Published var contacts = [Contact]()
    let db = Firestore.firestore()
    
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
                return Contact(id: id, name: name, phone: phone)
            }
        }
    }
    
    func addData(name: String, phone: String) {
        db.collection("contacts").addDocument(data: [ "name": name, "phone": phone]) { error in
            if let error = error {
                print("Error adding document")
            }
        }
    }
    
    func deleteData(docID: String) {
        db.collection("contacts").document(docID).delete() { error in
            if let error = error {
                print("Error deleting document")
            }
        }
    }
    
    
}
