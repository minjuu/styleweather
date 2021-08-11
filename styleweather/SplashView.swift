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

var clothes = [
    Cloth(title: "가디건", clothName: "t1"),
    Cloth(title: "반팔티",  clothName: "t2"),
    Cloth(title: "치마", clothName: "b1"),
]

var bottes = [
    Bott(title: "가디건", bottName: "t1"),
    Bott(title: "반팔티",  bottName: "t2"),
    Bott(title: "치마", bottName: "b1"),
]
let queue = DispatchQueue.main
struct SplashView: View {
    
    @State var isActive:Bool = false
    var body: some View {
        VStack {
            Text("")
                .onAppear(){
                        loadData()
                        loadCloth()
                        
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
    var count = 0
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
            count += 1
        } catch {
            print("Error serializing Json: ", error)
        }
        count += 1
    }.resume()
    
    

}

func loadCloth(){
    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
        print(curtemp)
        
        
            curtemp = 31
        if Int(curtemp) >= 28{
            clothes = [
                Cloth(title: "반팔티", clothName: "28t_반팔티"),
                Cloth(title: "반팔 블라우스",  clothName: "28t_반팔블라우스"),
                Cloth(title: "민소매", clothName: "28t_민소매"),
                Cloth(title: "린넨 셔츠", clothName: "28t_린넨 셔츠"),
            ]
            bottes = [
                Bott(title: "짧은 원피스", bottName: "28b_짧은 원피스"),
                Bott(title: "짧은 치마",  bottName: "28b_짧은 치마"),
                Bott(title: "반바지", bottName: "28b_반바지"),
                Bott(title: "면반바지", bottName: "28b_면반바지"),
            ]
        }
        else if Int(curtemp) >= 23{
            clothes = [
                Cloth(title: "반팔티", clothName: "27t_반팔티"),
                Cloth(title: "반팔 카라티",  clothName: "27t_반팔pk티"),
                Cloth(title: "얇은 셔츠", clothName: "27t_얇은 셔츠"),
                Cloth(title: "반팔 셔츠", clothName: "27t_반팔 셔츠"),
            ]
            bottes = [
                Bott(title: "짧은 치마", bottName: "27b_짧은 치마"),
                Bott(title: "면반바지",  bottName: "27b_면반바지"),
                Bott(title: "반바지", bottName: "27b_반바지"),
                Bott(title: "면바지", bottName: "27b_면바지"),
            ]
        }
        else if Int(curtemp) >= 20{
            clothes = [
                Cloth(title: "블라우스", clothName: "22t_블라우스"),
                Cloth(title: "티셔츠",  clothName: "22t_티셔츠"),
                Cloth(title: "긴팔 티", clothName: "22t_긴팔 티"),
                Cloth(title: "셔츠", clothName: "22t_셔츠"),
            ]
            bottes = [
                Bott(title: "얇은 바지", bottName: "22b_얇은 바지"),
                Bott(title: "긴 치마",  bottName: "22b_긴 치마"),
                Bott(title: "면바지", bottName: "22b_면바지"),
                Bott(title: "슬랙스", bottName: "22b_슬랙스"),
            ]
        }
        else if Int(curtemp) >= 17{
            clothes = [
                Cloth(title: "얇은 니트", clothName: "19t_얇은 니트"),
                Cloth(title: "후드티",  clothName: "19t_후드티"),
                Cloth(title: "얇은 가디건", clothName: "16t_가디건"),
                Cloth(title: "맨투맨", clothName: "19t_맨투맨"),
            ]
            bottes = [
                Bott(title: "긴 바지", bottName: "19b_긴 바지"),
                Bott(title: "긴 치마",  bottName: "19b_긴 치마"),
                Bott(title: "면바지", bottName: "19b_면바지"),
                Bott(title: "슬랙스", bottName: "19b_슬랙스"),
            ]
        }
        else if Int(curtemp) >= 12{
            clothes = [
                Cloth(title: "청자켓", clothName: "16t_청자켓"),
                Cloth(title: "자켓",  clothName: "16t_자켓"),
                Cloth(title: "가디건", clothName: "16t_가디건"),
                Cloth(title: "니트", clothName: "16t_니트"),
            ]
            bottes = [
                Bott(title: "청바지", bottName: "16b_청바지"),
                Bott(title: "긴 치마",  bottName: "16b_긴 치마"),
                Bott(title: "면바지", bottName: "16b_면바지"),
                Bott(title: "슬랙스", bottName: "16b_슬랙스"),
            ]
        }
        else if Int(curtemp) >= 9{
            clothes = [
                Cloth(title: "트렌치 코트", clothName: "11t_트렌치 코트"),
                Cloth(title: "니트",  clothName: "11t_니트"),
                Cloth(title: "자켓", clothName: "11t_자켓"),
                Cloth(title: "니트", clothName: "11t_니트"),
            ]
            bottes = [
                Bott(title: "청바지", bottName: "11b_청바지"),
                Bott(title: "긴 치마",  bottName: "11b_긴 치마"),
                Bott(title: "면바지", bottName: "11b_면바지"),
                Bott(title: "슬랙스", bottName: "11b_슬랙스"),
            ]
        }
        else if Int(curtemp) >= 5{
            clothes = [
                Cloth(title: "얇은 울코트", clothName: "8t_얇은 울코트"),
                Cloth(title: "라이더 자켓",  clothName: "8t_라이더 자켓"),
                Cloth(title: "니트", clothName: "8t_니트"),
                Cloth(title: "히트텍", clothName: "8t_히트텍"),
            ]
            bottes = [
                Bott(title: "청바지", bottName: "8b_청바지"),
                Bott(title: "긴바지",  bottName: "8b_긴 바지"),
                Bott(title: "두꺼운 바지", bottName: "8b_두꺼운 바지"),
                Bott(title: "레깅스", bottName: "8b_레깅스"),
            ]
        }
        else {
            clothes = [
                Cloth(title: "두꺼운 코트", clothName: "4t_두꺼운 코트"),
                Cloth(title: "패딩",  clothName: "4t_패딩"),
                Cloth(title: "기모 제품", clothName: "4t_기모 제품"),
                Cloth(title: "히트텍", clothName: "4t_히트텍"),
            ]
            bottes = [
                Bott(title: "청바지", bottName: "4b_청바지"),
                Bott(title: "긴바지",  bottName: "4b_긴 바지"),
                Bott(title: "두꺼운 바지", bottName: "4b_두꺼운 바지"),
                Bott(title: "기모 제품", bottName: "4b_기모 제품"),
            ]

        }
    }
//      폰트 이름 검사
//    for family: String in UIFont.familyNames {
//        print(family)
//        for names: String in UIFont.fontNames(forFamilyName: family)
//        { print("== \(names)") } }
}


