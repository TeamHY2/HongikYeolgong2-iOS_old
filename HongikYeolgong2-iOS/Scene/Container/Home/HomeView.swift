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
    @State private var showingDialog = false
    @State private var showingAlert = false
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: isStart ? UIScreen.UIHeight(11) : UIScreen.UIHeight(43))
            
            if isStart {
                TimeLapse()
            } else {
                Quote()
            }
            
            Spacer()
                .frame(height: isStart ? UIScreen.UIHeight(28) : UIScreen.UIHeight(120))
            
            if isStart {
                CustomButton(action: {
                    showingAlert = true
                }, font: .suite, title: "열람실 이용 종료", titleColor: .customGray100, backgroundColor: .customGray600, leading: 0, trailing: 0)
                
            } else {
                HStack {
                    CustomButton2(action: {}, title: "좌석", image: .angularButton01, maxWidth: 69, minHeight: 52)
                    
                    Spacer(minLength: 12)
                    
                    CustomButton2(action: {
                        showingDialog = true
                    }, title: "열람실 이용 시작", image: .angularButton02, maxWidth: .infinity, minHeight: 52)
                }
                
            }
            
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
        .dialog(isPresented: $showingDialog,
                confirmAction: {
            isStart = true
            print("확인버튼 눌림")
        }, cancelAction: {
        })
        .alert(title: "열람실을 다 이용하셨나요?", confirmButtonText: "네", cancleButtonText: "더 이용하기", isPresented: $showingAlert, confirmAction: {
            isStart = false
        }, cancelAction: {
            
        })
        
    }
}


#Preview {
    HomeView()
}
