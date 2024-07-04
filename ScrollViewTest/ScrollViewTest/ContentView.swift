//
//  ContentView.swift
//  ScrollViewTest
//
//  Created by 羅壽之 on 2023/3/28.
//

import SwiftUI
import PhotosUI

struct  Place: Identifiable {
    var id = UUID()
    var image: String
    var name: String
}


struct ContentView: View {
    
    var scenes = [
        Place(image:"photo0_0", name:"Tianyuan Temple"),
        Place(image:"photo0_1", name:"Taipei 101"),
        Place(image:"photo1_0", name:"Changchu Shrine"),
        Place(image:"photo1_1", name:"Swallow Grotto"),
        Place(image:"photo1_2", name:"Cimu Bridge"),
        Place(image:"photo2_0", name:"Kenting National Park"),
        Place(image:"photo2_1", name:"Longpan Park")
    ]
    
    @State var selected: Place?
    
    var body: some View {
        
        // vertical scroll view
        ScrollView {
            ForEach(scenes) {scene in
                CardView(image: scene.image, name: scene.name)
            }
        }
        
        // horizontal scroll view
        VStack {
            ScrollView(.horizontal, showsIndicators: true) {
                HStack {
                    ForEach(scenes) {scene in
                        CardView(image: scene.image, name: scene.name)
                            .frame(width: 200)
                            .onTapGesture {
                                selected = scene
                            }
                    }
                }
            }
            
            Text("Select: \(selected?.name ?? "")")
            Spacer()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
