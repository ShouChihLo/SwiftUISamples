//
//  ContentView.swift
//  BannerTest
//
//  Created by 羅壽之 on 2024/6/20.
//

import SwiftUI
import Pages

struct ContentView: View {
    
    var body: some View {
        VStack {
            //BannerWithPage()
            Banner()
                .frame(height: 150)

            Text("Main Screen").font(.title).padding()
            Spacer()
        }
    }
}

struct Banner: View {
    let banner_images = ["photo0_0", "photo0_1", "photo1_0", "photo1_1", "photo1_2", "photo2_0", "photo2_1"]
    
    @State private var selectedTab = 0
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        GeometryReader { geometry in
            TabView(selection: $selectedTab) {
                ForEach(Array(banner_images.enumerated()), id: \.element) { index, image in
                    Image(image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: 150)
                        .clipped()
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .onReceive(timer) { _ in
                withAnimation {
                    selectedTab = (selectedTab + 1) % banner_images.count
                }
            }
        }
    }
}

struct BannerWithPage: View {
    let banner_images = ["photo0_0", "photo0_1", "photo1_0", "photo1_1", "photo1_2", "photo2_0", "photo2_1"]
    
    @State private var selectedTab = 0
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            ModelPages(banner_images, currentPage: $selectedTab, navigationOrientation: .horizontal,transitionStyle: .pageCurl) { index, image in
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: 150)
                    .clipped()
                    .tag(index)
            }
            .onReceive(timer) { _ in
                withAnimation {
                    selectedTab = (selectedTab + 1) % banner_images.count
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
