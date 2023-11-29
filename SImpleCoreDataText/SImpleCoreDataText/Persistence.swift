//
//  Persistence.swift
//  SImpleCoreDataText
//
//  Created by 羅壽之 on 2023/4/25.
//

import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    init() {
        container = NSPersistentContainer(name: "ContactsModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
            print(error)
            }
        })
    }
    
    func saveData() {
        // if nothing changes on viewContext then return
        guard viewContext.hasChanges else { return }
        
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    func addData(name: String, phone: String) {
        // create an empty contact on viewContext
        let newContact = Contact(context: viewContext)
        // add values to the new contact
        newContact.name = name
        newContact.phone = phone
        
        saveData()
    }
    
    func deleteData(target: NSManagedObject) {
        viewContext.delete(target)
        
        saveData()
    }
    
}

