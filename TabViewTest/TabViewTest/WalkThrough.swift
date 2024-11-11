//
//  WalkThrough.swift
//  TabViewTest
//
//  Created by 羅壽之 on 2023/4/23.
//

import SwiftUI

struct WalkThrough: View {
    @AppStorage("walkthrough_done") var walkthrough_done = false
    
    @State var showWelcome = true
    
    var body: some View {
        Text("Main Screen")
            .sheet(isPresented: $showWelcome) {
                WelcomePages()
            }
            .onAppear {
                // enable the following line once to do re-test
                //walkthrough_done = false
                showWelcome = !walkthrough_done}
    }
}

struct WelcomePages: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var selectedTab = 0
    
    @AppStorage("walkthrough_done") var walkthrough_done = false
        
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                Group {
                    Image(systemName: "1.circle").tag(0)
                    Image(systemName: "2.circle").tag(1)
                    Image(systemName: "3.circle").tag(2)
                }
                .font(.system(size: 100))
                .foregroundColor(.blue)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
    
                Button(selectedTab != 2 ? "Next" : "Get started") {
                    if selectedTab != 2 {
                        selectedTab += 1
                    }
                    else {
                        walkthrough_done = true
                        presentationMode.wrappedValue.dismiss()
                    }
                }
      
        }
    }
}

struct WalkThrough_Previews: PreviewProvider {
    static var previews: some View {
        WalkThrough()
    }
}
