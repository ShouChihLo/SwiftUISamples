//
//  CollectionBinding.swift
//  ListOperationTest
//
//  Created by 羅壽之 on 2023/4/22.
//

import SwiftUI

struct Item: Identifiable {
    var id = UUID()
    var title: String
    var isDone = false
}

struct CollectionBinding: View {
    @State var items = [
        Item(title: "Item 0"),
        Item(title: "Item 1"),
        Item(title: "Item 2"),
        Item(title: "Item 3")
    ]
    
    var body: some View {
        List {
            ForEach(items.indices) { index in
                HStack() {
                    Text(items[index].title)
                    Toggle(isOn: $items[index].isDone) {
                        Text("Done")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
            }
        }
        
        // the following codes only works for iOS15+
//        List {
//            ForEach($items) { $item in
//                HStack() {
//                    Text(item.title)
//                    Toggle(isOn: $item.isDone) {
//                        Text("Done")
//                            .frame(maxWidth: .infinity, alignment: .trailing)
//                    }
//                }
//            }
//        }
        
    }
}

struct CollectionBinding_Previews: PreviewProvider {
    static var previews: some View {
        CollectionBinding()
    }
}
