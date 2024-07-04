//
//  ContentView.swift
//  ListTest
//
//  Created by 羅壽之 on 2023/1/16.
//

import SwiftUI

struct ContentView: View {
    
    let restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery"]
    
    let restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkeerestaurant", "posatelier", "bourkestreetbakery"]
    
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Searching", text: $searchText)
                
                List {
                    ForEach(restaurantNames.indices.filter {
                        searchText.isEmpty ? true : restaurantNames[$0].localizedCaseInsensitiveContains(searchText)
                    }, id: \.self) { index in
                        
                        HStack {
                            Image(restaurantImages[index])
                                .resizable()
                                .frame(width: 40, height: 40)
                                .cornerRadius(5)
                            
                            Text(restaurantNames[index])
                            
                        }
                        
                    }
                }  // list
                
                // the following codes only work for iOS15+
                //                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search ...")
                //                .listStyle(.plain)
                
                .listStyle(PlainListStyle())
                //  .listStyle(InsetListStyle())
                //  .listStyle(GroupedListStyle())
                // .listStyle(InsetGroupedListStyle())
                
            } // VStack
            
            .navigationTitle("Restaurant List")
            //.navigationBarHidden(true)
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
