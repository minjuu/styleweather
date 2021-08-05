//
//  ContentView.swift
//  styleweather
//
//  Created by 강민주 on 2021/08/04.
//

import SwiftUI

struct SplashView: View {
    
    // 1.
    @State var isActive:Bool = false
    
    var body: some View {
        VStack {
            // 2.
            if self.isActive {
                // 3.
                mainUI()
            } else {
                // 4.
                Image("logo")
                    .resizable()
                    .frame(width: 180, height: 142)
            }
        }
        // 5.
        .onAppear {
            // 6.
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                // 7.
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
    
}




