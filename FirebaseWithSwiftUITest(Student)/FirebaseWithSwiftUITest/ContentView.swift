//
//  ContentView.swift
//  FirebaseWithSwiftUITest
//
//  Created by 羅壽之 on 2023/11/29.
//

import SwiftUI
import NukeUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @State var showAddView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.contacts) { contact in
                    HStack {
                        if let imagePath = contact.photoPath {
                            LazyImage(source: imagePath)
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        }
                        
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
        .onAppear {
            viewModel.loadData()
        }
        
    }
    
    private func deleteContact(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        
        let contact = viewModel.contacts[index]
        viewModel.deleteData(docID: contact.id, photoPath: contact.photoPath)
    }
    
}

struct AddContactView: View {
    @EnvironmentObject var viewModel: ViewModel
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
            
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.addData(name: name, phone: phone, photo: photo)
                        presentationMode.wrappedValue.dismiss()
                    } label : {
                        Image(systemName: "checkmark")
                            .font(.headline)
                    }
                    .disabled(isDisable)
                }
            }
        } // navigationView
    }
    
    private var isDisable: Bool {
        name.isEmpty || phone.isEmpty
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
