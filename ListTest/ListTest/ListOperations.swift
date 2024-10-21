//
//  ListOperations.swift
//  ListTest
//
//  Created by Shou-Chih Lo on 2024/10/17.
//

import SwiftUI

struct ListOperations: View {
    
    let restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery"]
    
    let restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkeerestaurant", "posatelier", "bourkestreetbakery"]
    
    @State var searchText = ""
    
    @State var restaurants: [Restaurant] = []
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Searching", text: $searchText)
                    .padding(.leading)
                
                List {
                    ForEach(restaurants.filter {
                        searchText.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(searchText)
                    }, id: \.self) { restaurant in
                        // Solution for Xcode 12 only
                        CellView(sourceArray: $restaurants, restaurant: restaurant)
                        
                    } // ForEach
                    
                    .onDelete { indexSet in
                        restaurants.remove(atOffsets: indexSet)
                    }
                    
                    .onMove { indexSet, newOffset in
                        restaurants.move(fromOffsets: indexSet, toOffset: newOffset)
                    }
                    
                }  // list
                .listStyle(PlainListStyle())
                
            } // VStack
            
            .navigationTitle("Restaurant List")
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
        } // NavigationView
        
        .onAppear {
            // set the source data array
            restaurants = zip(restaurantNames,restaurantImages).map  { Restaurant(name: $0, image: $1)}
        }
        
    }
}


struct ListOperations_Previews: PreviewProvider {
    static var previews: some View {
        ListOperations()
    }
}

struct CellView: View {
    
    @Binding var sourceArray: [Restaurant]
    var restaurant: Restaurant
    
    var body: some View {
        HStack {
            Image(restaurant.image)
                .resizable()
                .frame(width: 40, height: 40)
                .cornerRadius(5)
            
            Text(restaurant.name)
            
            Spacer()
            
            Image(systemName: "heart.fill")
                .foregroundColor(.yellow)
                .opacity(restaurant.isFavorite ? 1 : 0)
        }
        
        .contextMenu {
            Button {
                // get the index of the restaurant within the source array
                if let index = sourceArray.firstIndex(of: restaurant) {
                    sourceArray[index].isFavorite.toggle()
                }
            } label: {
                Text(restaurant.isFavorite ? "UnLike" : "Like")
            }
        }
    }
}
