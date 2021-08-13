//
//  swinfo.swift
//  styleweather
//
//  Created by 강민주 on 2021/08/13.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation

struct Swinfo: View {
    @State private var selection = 2
    var body: some View {
        TabView(selection: $selection){
            Board().tabItem {
                        Image(systemName: "macwindow")
                    }.tag(1)

            mainUI().tabItem {
                        Image(systemName: "house")
                    }.tag(2)

            Mypage().tabItem {
                        Image(systemName: "person")
                    }.tag(3)
        }
    }
}

struct Swinfo_Previews : PreviewProvider {
    static var previews: some View { Swinfo() }
    
}

