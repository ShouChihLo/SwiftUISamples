//
//  ContentView.swift
//  ListOperationTest
//
//  Created by 羅壽之 on 2023/4/22.
//

import SwiftUI

struct ContentView: View {
    @State var lastIndex = 9
    @State var items: [String] = []
    @State var showConfirm = false
    @State var deletedSet = IndexSet()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items, id:\.self) { item in
                    Text(item)
                } // ForEach
                       
                .onDelete { indexSet in
                    // items.remove(atOffsets: indexSet)
                    showConfirm = true
                    deletedSet = indexSet
                }
                
                .onMove { indexSet, newOffset in
                    items.move(fromOffsets: indexSet, toOffset: newOffset)
                }
                
                .actionSheet(isPresented: $showConfirm) {
                    ActionSheet(
                        title: Text("Delete really"),
                        message: nil,
                        buttons: [
                            .default(Text("Confirm")) {
                                withAnimation {
                                    items.remove(atOffsets: deletedSet)
                                    
                                }
                            },
                            .cancel()
                        ]
                    )
                }
               
            } // List
            .navigationTitle("List Demo")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        lastIndex += 1
                        items.append("item \(lastIndex)")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
        } //navigation view
        
        .onAppear {
            items = (0...lastIndex).map {"item \($0)"}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
