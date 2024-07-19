//
//  HomeView.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/2/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var coordinator: SceneCoordinator
    @EnvironmentObject private var viewModel: HomeViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: viewModel.isRoomReserved ? UIScreen.UIHeight(11) : UIScreen.UIHeight(43))
            
            if viewModel.isRoomReserved {
                TimeLapse(startTime: viewModel.useageStartTime, endTime: viewModel.useageStartTime + TimeInterval(3600 * 4))
            } else {
                Quote()
            }
            
            Spacer()
                .frame(height: viewModel.isRoomReserved ? UIScreen.UIHeight(28) : UIScreen.UIHeight(120))
            
            if viewModel.isRoomReserved {
                CustomButton(action: {
                    viewModel.showingAlert2 = true
                }, font: .suite, title: "열람실 이용 연장", titleColor: .white, backgroundColor: .customBlue100, leading: 0, trailing: 0)
                
                Spacer().frame(height: UIScreen.UIHeight(12))
                
                CustomButton(action: {
                    viewModel.showingAlert = true
                }, font: .suite, title: "열람실 이용 종료", titleColor: .customGray100, backgroundColor: .customGray600, leading: 0, trailing: 0)
            } else {
                HStack {
                    CustomButton2(action: {}, title: "좌석", image: .angularButton01, maxWidth: 69, minHeight: 52)
                    
                    Spacer().frame(width: UIScreen.UIWidth(12))
                    
                    CustomButton2(action: {
                        viewModel.showingDialog = true
                    }, title: "열람실 이용 시작", image: .angularButton02, maxWidth: .infinity, minHeight: 52)
                }
                
            }
            
            Spacer()
            
            CalendarView()
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
        .dialog(isPresented: $viewModel.showingDialog,
                currentDate: $viewModel.useageStartTime,
                confirmAction: {
            viewModel.startRoomUsage()
            print("확인버튼 눌림")
        }, cancelAction: {
        })
        .alert(title: "열람실을 다 이용하셨나요?", confirmButtonText: "네", cancleButtonText: "더 이용하기", isPresented: $viewModel.showingAlert, confirmAction: {
            viewModel.cancleRoomUsage()
        }, cancelAction: {
            
        })
        .alert(title: "열람실 이용 시간을 연장할까요?", confirmButtonText: "연장하기", cancleButtonText: "아니오", isPresented: $viewModel.showingAlert2, confirmAction: {
            
        }, cancelAction: {
            
        })
    }
}


#Preview {
    HomeView()
}
