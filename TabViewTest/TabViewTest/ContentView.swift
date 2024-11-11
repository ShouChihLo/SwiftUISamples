//
//  ContentView.swift
//  TabViewTest
//
//  Created by 羅壽之 on 2023/4/1.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedTab = 0
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                Page1()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Page1")
                    }
                    .tag(0)
                
                Page2()
                    .tabItem {
                        Image(systemName: "bookmark.circle.fill")
                        Text("Page2")
                    }
                    .tag(1)
                
                Page3()
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Page3")
                    }
                    .tag(2)
            }
            .navigationTitle(ShowNavTitle(tabNumber: self.selectedTab))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Text("Go to")
                        Button("Page1") { selectedTab=0 }
                        Button("Page2") { selectedTab=1 }
                        Button("Page3") { selectedTab=2 }

                    } label: {
                        Image(systemName: "line.horizontal.3")
                    }
                }
            }
        }  // navigation view
//        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
//    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
    
    func ShowNavTitle(tabNumber: Int) -> String {
        switch tabNumber {
        case 0: return "Home Page"
        case 1: return "Item List"
        default: return "User Profile"
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Page1: View {
    
    var body: some View {
        Text("Page 1")
            .font(.title)
    }
}

struct Page2: View {
    
    var body: some View {
        //NavigationView {
            List {
                ForEach(["Item 1", "Item 2"], id:\.self) { item in
                    NavigationLink(
                        destination: Text("Description of " + item))
                    {
                        Text(item)
                    }
                }
            }
         //   .navigationTitle("Item List")
        //} // navigation view
    }
}

struct Page3: View {
    
    var body: some View {
        Text("Page 3")
            .font(.title)
    }
}
