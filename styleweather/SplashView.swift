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
var timezone = ""
var dts = ""
var t1 = ""
var t2 = ""
var t3 = ""
var t4 = ""
var t5 = ""
var t6 = ""

var i1 = ""
var i2 = ""
var i3 = ""
var i4 = ""
var i5 = ""
var i6 = ""

var d1 = ""
var d2 = ""
var d3 = ""
var d4 = ""
var d5 = ""
var d6 = ""

var longitude = ""
var latitude = ""
struct WeatherData: Decodable {
    let timezone: String
    let current : Current
    let hourly : [Hourly]
    
}

struct Current : Decodable {
    let dt : Int
    let humidity: Int
    let temp : Double
    let weather : [Weather]
}

struct Hourly : Decodable {
    let dt : Int
    let humidity: Int
    let temp : Double
    let weather : [Weather]
}
struct Weather: Decodable {
    let main: String
    let description: String
    let icon: String
}
struct Temp : Decodable {
    let day : Double
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

var weathers = [
    Weatherr(title: "오전 9시", weatherName: "10d", weathertemp: "26°"),
    Weatherr(title: "오후 12시",  weatherName: "10n", weathertemp: "26°"),
    Weatherr(title: "오후 3시", weatherName: "04n", weathertemp: "26°"),
    Weatherr(title: "오후 6시", weatherName: "04n", weathertemp: "26°"),
    Weatherr(title: "오후 9시", weatherName: "04n", weathertemp: "26°"),
    Weatherr(title: "오전 12시", weatherName: "04n", weathertemp: "26°"),
]

let queue = DispatchQueue.main
struct SplashView: View {
    @StateObject var locationManager = LocationManager()
        
        var userLatitude: String {
            latitude = "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
            return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
        }
        
        var userLongitude: String {
            longitude = "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
            return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
        }
    @State var isActive:Bool = false
    var body: some View {
        VStack {
            Text("")
                .onAppear(){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        loadData(lat: "\(userLatitude)",long: "\(userLongitude)")
                        loadCloth()
                    }
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
    
}


func loadData(lat: String, long: String) {
    print("위도 경도", lat, long)
    guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(long)&exclude=minutely,alerts&appid=fa6cc892ae147813637c852e0d803bd5") else {
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
            print("timezone: ", weatherData.timezone)
            timezone = weatherData.timezone
            print("temp: ",weatherData.current.temp - 273.15)
            curtemp = weatherData.current.temp - 273.15
            var i = 0
            weatherData.current.weather.forEach {
                print("current icon: ", $0.icon)
                icon = $0.icon
                print("current des: ",$0.description)
                des = $0.description
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d일 HH시"
            weatherData.hourly.forEach {
                print("dt: ",$0.dt)
                let date = NSDate(timeIntervalSince1970: Double($0.dt))
                print(date)
                
                let formatter = DateFormatter()
                // initially set the format based on your datepicker date / server String
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

                let myString = formatter.string(from: date as Date) // string purpose I add here // convert your string to date
                let yourDate = formatter.date(from: myString)
                formatter.dateFormat = "a h시"                      //then again set the date format whhich type of output you need
                formatter.locale = Locale(identifier:"ko_KR")
                formatter.timeZone = TimeZone(abbreviation: "KST")
                let myStringafd = formatter.string(from: yourDate!)   // again convert your date to string

                print(myStringafd)
                
                print("temp",i,": ", $0.temp-273.15)
                if i == 0{
                    t1 = String(Int($0.temp - 273.15))
                    i1 = $0.weather[0].icon
                    d1 = myStringafd
                }
                else if i == 3{
                    t2 = String(Int($0.temp - 273.15))
                    i2 = $0.weather[0].icon
                    d2 = myStringafd
                }
                else if i == 6{
                    t3 = String(Int($0.temp - 273.15))
                    i3 = $0.weather[0].icon
                    d3 = myStringafd
                }
                else if i == 9{
                    t4 = String(Int($0.temp - 273.15))
                    i4 = $0.weather[0].icon
                    d4 = myStringafd
                }
                else if i == 12{
                    t5 = String(Int($0.temp - 273.15))
                    i5 = $0.weather[0].icon
                    d5 = myStringafd
                }
                else if i == 15{
                    t6 = String(Int($0.temp - 273.15))
                    i6 = $0.weather[0].icon
                    d6 = myStringafd
                }
                print(i,": ", $0.weather[0].icon)
                print(i,": ",$0.weather[0].description)
                i += 1
                weathers = [
                    Weatherr(title: d1, weatherName: i1, weathertemp: t1+"°"),
                    Weatherr(title: d2,  weatherName: i2, weathertemp: t2+"°"),
                    Weatherr(title: d3, weatherName: i3, weathertemp: t3+"°"),
                    Weatherr(title: d4, weatherName: i4, weathertemp: t4+"°"),
                    Weatherr(title: d5, weatherName: i5, weathertemp: t5+"°"),
                    Weatherr(title: d6, weatherName: i6, weathertemp: t6+"°"),
                ]
            }
            
        } catch {
            print("Error serializing Json: ", error)
        }
    }.resume()
    
}

func loadCloth(){
    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
        print(curtemp)
        
        
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


