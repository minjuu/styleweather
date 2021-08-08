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
    var userData = posts
    var body: some View {
        VStack
        {
            HStack(alignment: .center, spacing: 25)
            {
                Text("   "+strtemp+"°C")
                    .font(.custom("Montserrat-ExtraLight", size: 50))
                    .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Image(icon.trimmingCharacters(in: .whitespaces))
                .resizable()
                .frame(width: 200, height: 200, alignment: .trailing)
            }
            
            }
            VStack(alignment:.leading, spacing:20 )
            {
                Text("#추천 OOTD 상의                                            ")
                    .font(.custom("Cafe24SsurroundAir", size: 20))
                
                ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                //userData 를 순환하면서 PostView 들을 HStack 에 넣고 ScrollView 생성
                                ForEach(userData) { post in
                                    PostView(post: post)
                                }
                            }
                        }
                Text("#추천 OOTD 하의                                               ")
                    .font(.custom("Cafe24SsurroundAir", size: 20))
                
                ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                //userData 를 순환하면서 PostView 들을 HStack 에 넣고 ScrollView 생성
                                ForEach(userData) { post in
                                    PostView(post: post)
                                }
                            }
                        }
            
            }
            
        }
    }
    
    

struct mainUI_Previews: PreviewProvider {
    static var previews: some View {
        mainUI()
    }
}

struct Post : Identifiable {
    let id = UUID()
    let title : String
    let genre : String
    let runningTime: String
    let producer : String
    let casting : String
    let posterName: String
}
//테스트용 영화 정보
let posts = [
    Post(title: "다만 악에서 구하소서", genre: "범죄 액션", runningTime: "108분" , producer: "홍원찬", casting: "황정민, 이정재", posterName: "movie_image"),
    Post(title: "오케이 마담", genre: "코미디, 액션", runningTime: "108분" , producer: "이철하", casting: "엄정화, 박성웅", posterName: "movie_image2"),
    Post(title: "테넷", genre: "액션 SF", runningTime: "150분" , producer: "크리스토퍼 놀란", casting: "존 데이비드 워싱턴, 로버트 패틴슨", posterName: "movie_image3"),
]



struct PostView: View {
    let post : Post
    var body: some View {
        VStack {
            HStack{
                Image(post.posterName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.system(size: 16, weight: .bold))
                    HStack {
                        Text("개요: \(post.genre)")
                            .font(.system(size: 12, weight: .light))
                        Text(post.runningTime)
                            .font(.system(size: 12, weight: .light, design: .default))
                    }
                    Text("감독: \(post.producer)")
                        .font(.system(size: 12, weight: .light))
                    Text("출연: \(post.casting)")
                        .font(.system(size: 12, weight: .light))
                    Spacer()
                }.padding(.top, 10)
                //.padding()
            }
        }
        .padding()
        .frame(height: 150)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3742149392, green: 0.3621929838, blue: 0.919604783, alpha: 0.8244663292)), Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .foregroundColor(.white)
        .cornerRadius(15.0)
    }
}
