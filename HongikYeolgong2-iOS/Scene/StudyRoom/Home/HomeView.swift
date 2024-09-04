//
//  HomeView.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/2/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showCompleteAlert = false
    @State private var showTimeExtensionAlert = false
    @State private var showingDialog = false
    @State private var showingMenuView = false
    @State private var showingWebView = false
    
    @EnvironmentObject private var timerViewModel: TimerViewModel
    @EnvironmentObject private var calendarViewModel: CalendarViewModel
    @EnvironmentObject private var authViewModel: AuthViewModel
    @EnvironmentObject private var remoteConfigManager: RemoteConfigManager
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: timerViewModel.isStart ? 11 : 43)
            
            // 타이머 시작
            if timerViewModel.isStart {
                timerView
            } else {
                readyView
            }
            
            if !calendarViewModel.currentMonth.isEmpty {
                CalendarView()
            } else {
                ProgressView()
            }
        }
        .padding(.horizontal, 28)
        
        .background(
            Image(.iOSBackground)
                .ignoresSafeArea(.all)
                .allowsHitTesting(false)
        )
        .customNavigation(left: {
            Text("홍익열공이")
                .font(.suite(size: 18, weight: .semibold))
                .foregroundStyle(.gray100)
        }, right: {
            Button(action: {
                showingMenuView = true
            }, label: {
                Image(.icHamburger)
            })
        })        
        .dialog(isPresented: $showingDialog,
                currentDate: $timerViewModel.startTime) {            
            Task {
                guard let studyTime = await remoteConfigManager.getStudyTime() else { return }
                timerViewModel.send(action: .setTime(studyTime))
                timerViewModel.send(action: .startButtonTap)
                calendarViewModel.send(action: .startStudy)
            }
        }
                .alert(title: "열람실을 다 이용하셨나요?",
                       confirmButtonText: "네",
                       cancleButtonText: "더 이용하기",
                       isPresented: $showCompleteAlert) {
                    saveStudyRecord()
                }
                       .alert(title: "열람실 이용 시간을 연장할까요?",
                              confirmButtonText: "연장하기",
                              cancleButtonText: "아니오",
                              isPresented: $showTimeExtensionAlert) {
                           timerViewModel.send(action: .addTimeButtonTap)
                       }
                              .navigationDestination(isPresented: $showingMenuView, destination: {
                                  MenuView()
                              })
                              .navigationDestination(isPresented: $showingWebView, destination: {
                                  WebView(url: Constants.Url.roomStatus)
                              })
                              .onReceive(timerViewModel.$remainingTime.filter { $0 <= 0 }) { _ in
                                  saveStudyRecord()
                              }.onChange(of: scenePhase, perform: { value in
                                  guard timerViewModel.isStart == true else { return }
                                  
                                  if value == .active {
                                      timerViewModel.send(action: .enterFoureground)
                                  } else if value == .background {
                                      timerViewModel.send(action: .enterBackground)
                                  }
                              })
                              .onChange(of: calendarViewModel.seletedDate, perform: { value in
                                  guard timerViewModel.isStart == true &&
                                            Calendar.current.isDateInToday(value)
                                  else { return }
                                  
                                  calendarViewModel.send(action: .startStudy)
                              })
                              .onAppear {
                                  if LocalNotificationService.shared.authStatus == .notDetermined {
                                      LocalNotificationService.shared.requestPermission()
                                  }
                              }
    }
}

// MARK: - SubView
extension HomeView {
    private var timerView: some View {
        Group {
            TimeLapse(startTime: timerViewModel.startTime,
                      endTime: timerViewModel.endTime,
                      timeRemaining: timerViewModel.remainingTime,
                      usageCount: calendarViewModel.todayStudyRoomUsageCount)
            
            
            if timerViewModel.remainingTime <= Constants.StudyRoomService.firstNotificationTime {
                HY2Button(title: "열람실 이용 연장",
                         textColor: Color.Primary.blue100,
                         fontSize: 16,
                         style: .roundedSmall) {
                    showTimeExtensionAlert = true
                }
            }
            
            HY2Button(title: "열람실 이용 종료",
                     textColor: Color.GrayScale.gray100,
                     fontSize: 16,
                     style: .roundedSmall,
                     backgroundColor: Color.GrayScale.gray600) {
                showCompleteAlert = true
            }
                     .padding(.top, 28)
            
            Spacer()
        }
    }
    
    private var readyView: some View {
        Group {
            Quote(wiseSaying: homeViewModel.randomSaying)
            
            Spacer()
            
            HStack {
                
                HY2Button(title: "좌석",
                         style: .background(image: .angularButton01)) {
                    showingWebView = true
                }
                .frame(maxWidth: 69)
                
                Spacer().frame(width: 12)
                
                HY2Button(title: "열람실 이용 시작",
                         style: .background(image: .angularButton02)) {
                    showingDialog = true
                }
            }
            
            Spacer().frame(height: 40)
        }
    }
}

// MARK: - Helpers
extension HomeView {
    func saveStudyRecord() {
        // 타이머 중지
        timerViewModel.send(action: .completeButtonTap)
        
        // 총시간
        let totalTime = timerViewModel.totalTime
        let studyRecord = StudyRoomUsage(date: Date(), duration: totalTime)
        
        // 캘린더 업데이트
        if let uid = authViewModel.user?.id {
            calendarViewModel.send(action: .saveButtonTap(studyRecord, uid))
        }
    }
}
