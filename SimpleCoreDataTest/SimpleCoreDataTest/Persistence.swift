//
//  Persistence.swift
//  SImpleCoreDataText
//
//  Created by 羅壽之 on 2023/4/25.
//

import CoreData
import SwiftUI

struct PersistenceController {
    
    static let shared = PersistenceController()
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        // write one test data
        let newContact = Contact(context: viewContext)
        newContact.name = "Robert"
        newContact.phone = "09123456"
        newContact.photo = UIImage(systemName: "person.circle")!.pngData()
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    let container: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ContactsModel")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
            print(error)
            }
        })
        
        // get the file path in the simulator for debugging
        if let url = container.persistentStoreCoordinator.persistentStores.first?.url {
            //print(url)
        }
    }
    
    static func saveData(viewContext: NSManagedObjectContext) {
        // if nothing changes on viewContext then return
        guard viewContext.hasChanges else { return }
        
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    static func addData(viewContext: NSManagedObjectContext, name: String, phone: String, photo: UIImage) {
        // create an empty contact on viewContext
        let newContact = Contact(context: viewContext)
        // add values to the new contact
        newContact.name = name
        newContact.phone = phone
        newContact.photo = photo.pngData()
        
        saveData(viewContext: viewContext)
    }
    
    static func deleteData(viewContext: NSManagedObjectContext, target: NSManagedObject) {
        viewContext.delete(target)
        
        saveData(viewContext: viewContext)
    }
    
}

