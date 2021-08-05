//
//  mainUI.swift
//  styleweather
//
//  Created by 강민주 on 2021/08/05.
//

import Foundation
import SwiftUI

struct mainUI: View {
    var body: some View {
//        Image(systemName: "flame.fill")
//            .font(.system(size: 200))
//            .foregroundColor(.pink)
//            .shadow(color:.gray,radius: 2, x:2,y:10)
        VStack
        {
            Image("logo2")
                .resizable()
                .frame(width: 100, height: 80)
            Text("main page 입니다!")
        }
    }
struct mainUI_Previews: PreviewProvider {
    static var previews: some View {
        mainUI()
    }
}
}
