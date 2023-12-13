//
//  ContentView.swift
//  WeatherForcast
//
//  Created by 羅壽之 on 2023/4/11.
//

import SwiftUI

struct ContentView: View {
    let cities = ["Taipei", "Sydney", "London", "Tokyo"]
    
    @State var selectedIndex: Int? = nil
    
    @StateObject var weatherPublisher = WeatherPublisher()
    
    var body: some View {
        VStack {
            Picker(selection: $selectedIndex, label: Text("Select city")) {
                ForEach(cities.indices, id:\.self) { index in
                    Text(cities[index]).tag(index as Int?)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            .onChange(of: selectedIndex) { index in
                if let index = index {
                    weatherPublisher.getForecase(location: cities[index])
                }
            }
        
            WeatherView(weather: weatherPublisher.cityWeather)
            
            Spacer()
        }
    }

}

struct WeatherView: View {

    var weather: CityWeather
    
    var body: some View {
        VStack {
            Text(weather.name)
                .padding()
            Text(weather.description)
                .padding()
            Image(uiImage: weather.image)
            Text(weather.name.isEmpty ? "" : String(weather.temp)+" ℃")
                .padding()
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
