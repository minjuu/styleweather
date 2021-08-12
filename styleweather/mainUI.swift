//
//  mainUI.swift
//  styleweather
//
//  Created by 강민주 on 2021/08/05.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation

struct mainUI: View {
    var strtemp = String(Int(curtemp))
    var clothData = clothes
    var bottData = bottes
    var weatherData = weathers
    @State private var selection = 2
    var body: some View {
//        TabView(selection: $selection){
//            mainUI().tabItem {
//                        Image(systemName: "1.circle")
//                        Text("one")
//                    }.tag(1)
//            
//                Text("Tab Content 2")
//                    .tabItem {
//                        Image(systemName: "2.circle")
//                        Text("two")
//                    }.tag(2)
//                
//                Text("Tab Content 3")
//                    .tabItem {
//                        Image(systemName: "1.circle")
//                        Text("one")
//                    }.tag(3)
//        }
        ScrollView
        {
            HStack(alignment: .center, spacing: nil)
            {
                Image("location")
                    .resizable()
                    .frame(width: 22, height: 22, alignment: .center)
            
                Text(timezone)
                    .font(.custom("NanumSquareRoundR", size: 19))
                    .frame(width:120,alignment: .center)
            }
            HStack(alignment: .center)
            {
                VStack{
                Text(strtemp+"°C  ")
                    .font(.custom("Montserrat-ExtraLight", size: 50))
                    .frame(width:120,alignment: .leading)
                    .padding([.leading],70)
                
                    Text(des)
                        .font(.custom("Montserrat-ExtraLight", size: 20))
                        .frame(width:160,alignment: .trailing)
                }
                Image(icon.trimmingCharacters(in: .whitespaces))
                    .resizable()
                    .frame(width: 120, height: 120, alignment: .trailing)
                    .padding([.leading],20)
                Text("   ")
                    .font(.custom("Montserrat-ExtraLight", size: 50))
                    .frame(height:250,alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            .frame(width: 400, height: 180, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        
            VStack(alignment:.leading, spacing:20 )
            {
                Text("#추천 OOTD 상의")
                    .font(.custom("Cafe24SsurroundAir", size: 17))
                    .padding(.leading, 10)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                    //userData 를 순환하면서 ClothView 들을 HStack 에 넣고 ScrollView 생성
                    ForEach(clothData) {
                        cloth in ClothView(cloth: cloth)
                        }
                    }
                }
                .padding(.bottom,30)
                Text("#추천 OOTD 하의")
                    .font(.custom("Cafe24SsurroundAir", size: 17))
                    .padding(.leading, 10)
            
            
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        //userData 를 순환하면서 ClothView 들을 HStack 에 넣고 ScrollView 생성
                        ForEach(bottData) {
                            bott in BottView(bott: bott)
                        }
                    }
                }
                .padding(.bottom,30)
                
                Text("# 24h 날씨")
                    .font(.custom("Cafe24SsurroundAir", size: 18))
                    .frame(alignment:.leading)
                    .padding(.leading, 10)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        //userData 를 순환하면서 ClothView 들을 HStack 에 넣고 ScrollView 생성
                        ForEach(weatherData) {
                            weather in WeatherView(weather: weather)
                        }
                        .frame(width:75, height: 128)
                    }
                }
                .padding(.bottom,40)
            }
        }
    }
}
    

    
    

struct mainUI_Previews: PreviewProvider {
    static var previews: some View {
        mainUI()
    }
}

struct Cloth : Identifiable {
    let id = UUID()
    let title : String
    let clothName: String
}

struct Bott : Identifiable {
    let id = UUID()
    let title : String
    let bottName: String
}

struct Weatherr : Identifiable {
    let id = UUID()
    let title : String
    let weatherName: String
    let weathertemp: String
}

struct ClothView: View {
    let cloth : Cloth
    var body: some View {
        VStack {
            VStack{
                
                Image(cloth.clothName)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
                    .resizable()
                    .frame(width:70, height:70)
                    .aspectRatio(contentMode: .fit)
                VStack(alignment: .leading) {
                    Text(cloth.title)
                        .font(.custom("나눔손글씨 중학생", size: 20))
//                    BMHANNAAirOTF Cafe24-Ohsquareair
                    Spacer()
                }.padding(.top, 5)
            }
        }
        .padding(10)
        .frame(width:110, height: 130)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)), Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .foregroundColor(.black)
        .cornerRadius(15.0)
    }
}

struct BottView: View {
    let bott : Bott
    var body: some View {
        VStack {
            VStack{
                
                Image(bott.bottName)
                    .resizable()
                    .frame(width:70, height:70)
                    .aspectRatio(contentMode: .fit)
                VStack(alignment: .leading) {
                    Text(bott.title)
                        .font(.custom("나눔손글씨 중학생", size: 20))
//                    BMHANNAAirOTF Cafe24-Ohsquareair
                    Spacer()
                }.padding(.top, 5)
            }
        }
        .padding(10)
        .frame(width:110, height: 130)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)), Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .foregroundColor(.black)
        .cornerRadius(15.0)
    }
}

struct WeatherView: View {
    let weather : Weatherr
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                Text(weather.title)
                    .font(.custom("NanumSquareRoundR", size: 14))
                    .padding(.bottom,2)
                Image(weather.weatherName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:57, height:50)
                Text(weather.weathertemp)
                    .font(.custom("NanumSquareRoundR", size: 17))
                    Spacer()
            
        }
        .padding(10)
        .frame(width:110, height: 130)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)), Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .foregroundColor(.black)
        .cornerRadius(15.0)
    }
    
}


