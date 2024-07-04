//
//  ContentView.swift
//  LazyContainerTest
//
//  Created by 羅壽之 on 2023/4/14.
//

import SwiftUI

struct ContentView: View {
    
    var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkeerestaurant", "posatelier", "bourkestreetbakery"]
    
    let gridLayoutV = Array(repeating: GridItem(), count: 2)
    let gridLayoutH = Array(repeating: GridItem(), count: 3)

    var body: some View {
        // demo on LazyVStack
        ScrollView {
            LazyVStack {
                ForEach(restaurantImages, id:\.self) { image in
                    Image(image)
                        .resizable()
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 200)
                }
            }
        }
        
        // demo on LazyVGrid
        ScrollView {
            LazyVGrid(columns: gridLayoutV, spacing: 10) {
                ForEach(restaurantImages, id:\.self) { image in
                    Image(image)
                        .resizable()
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 100)
                }
            }
        }
        
        // demo on LazyHGrid
        VStack {
            ScrollView(.horizontal) {
                LazyHGrid(rows: gridLayoutH) {
                    ForEach(restaurantImages, id:\.self) { image in
                        Image(image)
                            .resizable()
                            .frame(width: 150, height: 100)
                    }
                }
            }
            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
