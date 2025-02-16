import SwiftUI
import AuthenticationServices

struct MenuView: View {    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State var isOn: Bool = false
    @State private var logoutAlert = false
    @State private var deleteAccountAlert = false
    @State private var isOnAlarm = UserDefaults.standard.bool(forKey: "isOnAlarm")
    
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var noticeWebView = false
    @State private var questionWebView = false
    
    var body: some View {
        ZStack {            
            VStack(spacing: 0) {
                Button(action: {noticeWebView.toggle()}
                       , label: {
                    Text("공지사항")
                        .font(.pretendard(size: 16, weight: .regular))
                        .foregroundStyle(Color.GrayScale.gray200)
                        .minimumScaleFactor(0.2)
                        .frame(maxWidth: UIScreen.UIWidth(311), minHeight: UIScreen.UIHeight(52), alignment: .leading)
                        .padding(.leading, UIScreen.UIWidth(16))
                    
                    Image("ic_arrowRight")
                        .padding(.trailing, UIScreen.UIWidth(11))
                })
                .background(Color.GrayScale.gray800)
                .cornerRadius(8)
                .padding(.bottom, UIScreen.UIHeight(20))
                .fullScreenCover(isPresented: $noticeWebView) {
                    WebViewWithCloseButton(url: URL(string: Constants.Url.notice)!)
                }
                
                Button(action: {questionWebView.toggle()}
                       , label: {
                    Text("문의사항")
                        .font(.pretendard(size: 16, weight: .regular))
                        .foregroundStyle(Color.GrayScale.gray200)
                        .minimumScaleFactor(0.2)
                        .frame(maxWidth: UIScreen.UIWidth(311), minHeight: UIScreen.UIHeight(52), alignment: .leading)
                        .padding(.leading, UIScreen.UIWidth(16))
                    Image("ic_arrowRight")
                        .padding(.trailing, UIScreen.UIWidth(11))
                })
                .background(Color.GrayScale.gray800)
                .cornerRadius(8)
                .padding(.bottom, UIScreen.UIHeight(20))
                .fullScreenCover(isPresented: $questionWebView) {
                    WebViewWithCloseButton(url: URL(string: Constants.Url.Qna)!)
                }
                
                HStack(spacing: 0) {
                    Text("열람실 종료 시간 알림")
                        .font(.pretendard(size: 16, weight: .regular))
                        .foregroundStyle(Color.GrayScale.gray200)
                        .minimumScaleFactor(0.2)
                        .frame(maxWidth: UIScreen.UIWidth(311), minHeight: UIScreen.UIHeight(52), alignment: .leading)
                        .padding(.leading, UIScreen.UIWidth(16))
                    Toggle("", isOn: Binding(
                        get: { isOnAlarm },
                        set: {
                            if LocalNotificationService.shared.authStatus == .authorized {
                                isOnAlarm = $0
                                UserDefaults.standard.set($0, forKey: "isOnAlarm")
                                HapticManager.shared.hapticImpact(style: .light)
                            } else {
                                if let url = URL(string: UIApplication.openNotificationSettingsURLString) {
                                    UIApplication.shared.open(url)
                                }
                            }
                        }
                    ))
                    .toggleStyle(ColoredToggleStyle(onColor:Color.Primary.blue100))
                }
                .background(Color.GrayScale.gray800)
                .cornerRadius(8)
                .padding(.bottom, UIScreen.UIWidth(8))
                
                HStack(spacing: 0){
                    Image("ic_information")
                        .padding(.trailing, UIScreen.UIWidth(6))
                    Text("열람실 종료 10분, 30분 전에 알림을 보내 연장을 돕습니다.")
                        .font(.pretendard(size: 12, weight: .regular))
                        .foregroundColor(Color.GrayScale.gray200)
                    Spacer()
                }
                
                Spacer()
                
                HStack(spacing: 0) {
                    Button(action: {
                        logoutAlert = true
                    }, label: {
                        Text("로그아웃")
                            .font(.pretendard(size: 16, weight: .regular))
                            .foregroundStyle(Color.GrayScale.gray300)
                            .frame(width: UIScreen.UIWidth(56), height: UIScreen.UIHeight(26))
                    })
                    
                    Text("|")
                        .font(.pretendard(size: 16, weight: .regular))
                        .foregroundStyle(Color.GrayScale.gray300)
                        .padding(.horizontal, UIScreen.UIWidth(24))
                    
                    Button(action: {
                        deleteAccountAlert = true
                    }, label: {
                        Text("회원탈퇴")
                            .font(.pretendard(size: 16, weight: .regular))
                            .foregroundStyle(Color.GrayScale.gray300)
                            .frame(width: UIScreen.UIWidth(56), height: UIScreen.UIHeight(26))
                    })
                }
                
            }
            .padding(.horizontal, 28)
            .customNavigation(left: {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image("ic_back")
                })
            })
        }
        .onAppear {
            Task {
                await LocalNotificationService.shared.checkPermission()
            }
        }
        .onChange(of: scenePhase) { phase in
            // 설정이 바뀌고나서 권한체크
            if phase == .active {
                Task {
                    await LocalNotificationService.shared.checkPermission()
                    if LocalNotificationService.shared.authStatus != .authorized {
                        isOnAlarm = false
                    }
                }
            }
        }
        .alert(title: "로그아웃 하실 건가요?", 
               confirmButtonText: "돌아가기",
               cancleButtonText: "로그아웃하기",
               isPresented: $logoutAlert,
               confirmAction: {
            
        }, cancelAction: {
                authViewModel.send(action: .logOut)
        })        
        .alert(title: "정말 탈퇴하실 건가요?", confirmButtonText: "돌아가기", cancleButtonText: "탈퇴하기", isPresented: $deleteAccountAlert, confirmAction: {
            
        }, cancelAction: {
            authViewModel.send(action: .deleteAccount)            
        })
    }
}

struct ColoredToggleStyle: ToggleStyle {
    var label = ""
    var onColor = Color.green
    var offColor = Color.GrayScale.gray200
    var thumbColor = Color.white
    
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            Text(label)
            Spacer()
            Button(action: { configuration.isOn.toggle() } )
            {
                RoundedRectangle(cornerRadius: 16, style: .circular)
                    .fill(configuration.isOn ? onColor : offColor)
                    .frame(width: 50, height: 29)
                    .overlay(
                        Circle()
                            .fill(thumbColor)
                            .shadow(radius: 1, x: 0, y: 1)
                            .padding(1.5)
                            .offset(x: configuration.isOn ? 10 : -10))
                    .onChange(of: configuration.isOn) { _ in
                        withAnimation(.easeInOut(duration: 0.25)) {
                        }
                    }
            }
        }
        .font(.title)
        .padding(.horizontal)
    }
}


#Preview {
    MenuView()
}
