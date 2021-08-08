//
//  ContentView.swift
//  styleweather
//
//  Created by 강민주 on 2021/08/04.
//

import SwiftUI
import SwiftUI
import Combine
import CoreLocation


var curtemp = 0.0
var icon = ""
var des = ""

struct WeatherData : Decodable {
    let coord : Coordinate
    let cod, visibility, id : Int
    let name : String
    let base : String
    let weather : [Weather]
    let sys : Sys
    let main : Main
    let wind : Wind
    let dt : Date
}

struct Coordinate : Decodable {
    let lat, lon : Double
}

struct Weather : Decodable {
    let id : Int
    let icon : String
    let main : MainEnum
    let description: String
}

struct Sys : Decodable {
    let type, id : Int
    let sunrise, sunset : Date
    let country : String
}

struct Main : Decodable {
    let temp, tempMin, tempMax : Double
    let pressure, humidity : Int
}

struct Wind : Decodable {
    let speed : Double
    let deg : Double?
    let gust : Double?
}

enum MainEnum: String, Decodable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}
struct SplashView: View {
    
    @State var isActive:Bool = false
    
    var body: some View {
        VStack {
            Text("")
                .onAppear(){
                    loadData()
                }
            if self.isActive {
                mainUI()
            } else {
                Image("logo")
                    .resizable()
                    .frame(width: 180, height: 142)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
    
}


func loadData() {
    guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Seoul&appid=fa6cc892ae147813637c852e0d803bd5") else {
        fatalError("Invalid URL")
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data, error == nil else {
            return
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .secondsSince1970
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            print("Coordinates: ", weatherData.coord)
            print("Longitude: ", weatherData.coord.lon)
            print("Latitude: ", weatherData.coord.lat)
            print("Weather: ", weatherData.weather)
            print("Temperature: ", weatherData.main.temp - 273.15)
            print("Temperature_Max: ", weatherData.main.tempMax - 273.15)
            print("Temperature_Min: ", weatherData.main.tempMin - 273.15)
            weatherData.weather.forEach {
                print("icon: ", $0.icon)
                icon = $0.icon
                print("description: ", $0.description)
                des = $0.description
            }
            curtemp = weatherData.main.temp - 273.15

        } catch {
            print("Error serializing Json: ", error)
        }
        
        
    }.resume()
}



