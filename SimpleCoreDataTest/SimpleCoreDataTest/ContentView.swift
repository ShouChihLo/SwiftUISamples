//
//  ContentView.swift
//  SImpleCoreDataText
//
//  Created by 羅壽之 on 2023/4/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var showAddView = false
    @State var showEditView = false
    @State var searchText = ""
    @State var editContact: Contact = Contact()
    
    @Environment(\.managedObjectContext) var viewContext
    
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
                            if let imageData = contact.photo {
                                Image(uiImage: UIImage(data: imageData)!)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .scaledToFit()
                                    .clipShape(Circle())
                            }

                            Text(contact.name ?? "-")
                            Spacer()
                            Text(contact.phone ?? "-")
                        }
                        // edit data
                        .onLongPressGesture {
                            editContact = contact
                            showEditView.toggle()
                        }
                        
                        .sheet(isPresented: $showEditView) {
                            EditContactView(contact: $editContact)
                        }
                    }
                    .onDelete { indexSet in
                        deleteContact(at: indexSet)
                    }
                }
                .listStyle(PlainListStyle())
           } // VStack
            
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
        
        PersistenceController.deleteData(viewContext: viewContext, target: contacts[index])
    }
    
    private func predicate(_ contact: Contact) -> Bool {
        searchText.isEmpty ? true : contact.name!.localizedCaseInsensitiveContains(searchText)
    }
    
}

struct AddContactView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State var name: String = ""
    @State var phone: String = ""
    @State var photo: UIImage = UIImage(systemName: "person.circle")!
    @State var showPicker = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(uiImage: photo)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 150, height: 150)
                    .onTapGesture {
                        showPicker.toggle()
                    }
                   
                TextField("Input name", text: $name)
                TextField("Input phone number", text: $phone)
                    .keyboardType(.phonePad)
                Spacer()
            }
            .padding()
            
            .sheet(isPresented: $showPicker) {
                ImagePicker(isPresented: $showPicker, selected: $photo)
            }
            
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
        PersistenceController.addData(viewContext: viewContext, name: name, phone: phone, photo: photo)
    }
    
}

struct EditContactView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var contact: Contact
    
    @State var name: String = ""
    @State var phone: String = ""
    @State var photo: UIImage = UIImage()
    @State var showPicker = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(uiImage: photo)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 150, height: 150)
                    .onTapGesture {
                        showPicker.toggle()
                    }
                   
                TextField("Input name", text: $name)
                TextField("Input phone number", text: $phone)
                    .keyboardType(.phonePad)
                Spacer()
            } // VStack
            .padding()
            
            .sheet(isPresented: $showPicker) {
                ImagePicker(isPresented: $showPicker, selected: $photo)
            }
            
            .navigationTitle("Edit Contact")
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
                        contact.name = name
                        contact.phone = phone
                        contact.photo = photo.pngData()
                        PersistenceController.saveData(viewContext: viewContext)
                        presentationMode.wrappedValue.dismiss()
                    } label : {
                        Image(systemName: "checkmark")
                            .font(.headline)
                    }
                    .disabled(isDisable)
                }
            }
            
        } // NavigationView
        .onAppear {
            name = contact.name!
            phone = contact.phone!
            photo = UIImage(data: contact.photo!)!
        }
        
    } // body
    
    private var isDisable: Bool {
        name.isEmpty || phone.isEmpty
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.viewContext)
    }
}
