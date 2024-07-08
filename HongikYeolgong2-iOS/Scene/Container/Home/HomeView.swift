//
//  HomeView.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/2/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var coordinator: SceneCoordinator
    @State private var isStart = false
    
    var body: some View {
        
        VStack(spacing: 0) {
            if isStart {
                
            } else {
                Quote()
                    .padding(.top, UIScreen.UIHeight(43))
            }
                        
            HStack(spacing: 0) {
                if isStart {
                    CustomButton(action: {
                        isStart = false
                    }, font: .suite, title: "열람실 이용 종료", titleColor: .customGray100, backgroundColor: .customGray600, leading: 0, trailing: 0)
                } else {
                    CustomButton2(action: {}, title: "좌석", image: .angularButton01, maxWidth: 69, minHeight: 52)
                    
                    Spacer(minLength: 12)
                    
                    CustomButton2(action: {
                        isStart = true
                    }, title: "열람실 이용 시작", image: .angularButton02, maxWidth: .infinity, minHeight: 52)
                }
            }
            .padding(.top, UIScreen.UIHeight(120))
            
            Spacer()
        }
        .customNavigation(left: {
            CustomText(font: .suite, title: "홍익열공이", textColor: .customGray100, textWeight: .semibold, textSize: 18)
        }, right: {
            Button(action: {
                coordinator.push(.menu)
            }, label: {
                Image(.icHamburger)
            })
        })
    }
}


#Preview {
    HomeView()
}
