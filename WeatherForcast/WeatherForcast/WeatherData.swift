//
//  WeatherData.swift
//  WeatherForcast
//
//  Created by 羅壽之 on 2023/4/11.
//

import UIKit
import Combine

struct WeatherData: Codable {
    var name: String
    var main: Main
    var weather: [Weather]
}

struct Main: Codable {
    var temp: Double
    var humidity: Int
}

struct Weather: Codable {
    var description: String
    var icon: String
}


struct CityWeather {
   var name: String = ""
   var temp: Double = 0
   var description: String = ""
   var image: UIImage = UIImage()
}

class WeatherPublisher: ObservableObject {
    @Published var cityWeather = CityWeather()
    
    private var subscriptionSet = Set<AnyCancellable>()
    
    func getForecase(location: String) {
        let API_URL = "https://api.openweathermap.org/data/2.5/weather?"
        let API_KEY = "Type_Your_API_Key_Here"
        
        // reset the cityWeather at the begining
        cityWeather = CityWeather()
        
        guard let accessURL = URL(string: API_URL +
                                    "q=\(location)&units=metric&appid=\(API_KEY)")
        else { return }
        
     // The following codes are based on URLSession
//        let task = URLSession.shared.dataTask(with: accessURL) { data, response, error  in
//            if let error = error { print(error) ; return }
//
//            // Parse JSON data
//            if let data = data {
//                let decoder = JSONDecoder()
//                if let weatherData = try? decoder.decode(WeatherData.self, from: data) {
//                    DispatchQueue.main.async {
//                        // Update state variables that are bound to UI views
//                        print(weatherData)
//                        self.cityWeather.name = weatherData.name
//                        self.cityWeather.temp = weatherData.main.temp
//                        self.cityWeather.description = weatherData.weather[0].description
//                    }
//                }
//            }
//        }
//
//        task.resume()
        
        // The following codes are based on Combine
        let publisher = URLSession.shared.dataTaskPublisher(for: accessURL)
  
        publisher
            .map { $0.data }
            .decode(type: WeatherData.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        print("Error: \(error)")
                    case .finished:
                        print("Finished")
                    }
                },
                receiveValue: { weatherData in
                    self.cityWeather.name = weatherData.name
                    self.cityWeather.temp = weatherData.main.temp
                    self.cityWeather.description = weatherData.weather[0].description
                    self.getIconImage(iconName: weatherData.weather[0].icon)
                }
            )
            .store(in: &subscriptionSet)
    }
    
    func getIconImage(iconName: String) {
        
        let ICON_URL = "https://openweathermap.org/img/wn/"
        
        guard let accessURL = URL(string: ICON_URL + "\(iconName)@2x.png") else {
            return
        }
        
        let publisher = URLSession.shared.dataTaskPublisher(for: accessURL)
  
        publisher
            .map { $0.data }
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        print("Error: \(error)")
                    case .finished:
                        print("Finished")
                    }
                },
                receiveValue: { imageData in
                    if let image = UIImage(data: imageData) {
                        self.cityWeather.image = image
                    }
                }
            )
            .store(in: &subscriptionSet)
    
    }
    
}

