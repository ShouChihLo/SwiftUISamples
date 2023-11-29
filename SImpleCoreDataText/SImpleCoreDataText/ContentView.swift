//
//  ContentView.swift
//  SImpleCoreDataText
//
//  Created by 羅壽之 on 2023/4/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var showAddView = false
    @State var searchText = ""
    
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(keyPath: \Contact.name, ascending: true)
    ], animation: .default)
    
    private var contacts: FetchedResults<Contact>
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
               SearchBar(text: $searchText)
                List {
                    ForEach(contacts.filter{predicate($0)}) { contact in
                        HStack {
                            Text(contact.name ?? "-")
                            Spacer()
                            Text(contact.phone ?? "-")
                        }
                    }
                    .onDelete { indexSet in
                        deleteContact(at: indexSet)
                    }
                }
                .listStyle(PlainListStyle())
                //.searchable(text: $searchText)
           }
            
            .navigationTitle("Contact List")
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddView.toggle()
                    } label : {
                        Image(systemName: "plus")
                            .font(.headline)
                    }
                }
            }
            
            .sheet(isPresented: $showAddView) {
                AddContactView()
            }
        }  // navigationView
        
//        .onChange(of: searchText) { text in
//            let predicate = text.isEmpty ? NSPredicate(value: true) : NSPredicate(format: "name CONTAINS[c] %@", text)
//            
//            contacts.nsPredicate = predicate
//        }
    }
    
    private func deleteContact(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        
        PersistenceController.shared.deleteData(target: contacts[index])
    }
    
    private func predicate(_ contact: Contact) -> Bool {
        searchText.isEmpty ? true : contact.name!.localizedCaseInsensitiveContains(searchText)
    }
    
}

struct AddContactView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var name: String = ""
    @State var phone: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Input name", text: $name)
                TextField("Input phone number", text: $phone)
                    .keyboardType(.phonePad)
                Spacer()
            }
            .padding()
            
            .navigationTitle("New Contact")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label : {
                        Image(systemName: "xmark")
                            .font(.headline)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addNewContact()
                        presentationMode.wrappedValue.dismiss()
                    } label : {
                        Image(systemName: "checkmark")
                            .font(.headline)
                    }
                    .disabled(isDisable)
                }
            }
        }
    }
    
    private var isDisable: Bool {
        name.isEmpty || phone.isEmpty
    }
    
    func addNewContact()  {
        PersistenceController.shared.addData(name: name, phone: phone)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.shared.viewContext)
    }
}
