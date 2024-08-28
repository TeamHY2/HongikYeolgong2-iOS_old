
import SwiftUI

struct JoinView: View {
    @StateObject private var joinVM = JoinViewModel()
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    @State var suggestions = [
        "건설도시공학부",
        "건설환경공학과",
        "건축학부",
        "경영학부",
        "경제학부",
        "공연예술학부",
        "금속조형디자인과",
        "기계시스템디자인공학과",
        "국어교육과",
        "국어국문학과",
        "도시공학과",
        "독어독문학과",
        "동양화과",
        "도예유리과",
        "디자인경영융합학부",
        "디자인·예술경영학부",
        "디자인학부",
        "물리교육과",
        "법학부",
        "불어불문학과",
        "사회교육과",
        "산업디자인학과",
        "산업·데이터공학과",
        "섬유미술패션디자인과",
        "수학교육과",
        "신소재화공시스템공학부",
        "영어교육과",
        "영어영문학과",
        "역사교육과",
        "예술학과",
        "응용미술학과",
        "일본어문학과",
        "전자전기공학부",
        "조소과",
        "컴퓨터공학과",
        "판화과",
        "프랑스어문학과",
        "회화과"
    ]
    
    @State var showSuggestions: Bool = false
    @State var allClear: Bool = false
    
    var body: some View {
        ZStack {
            Color(.customBackground)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing:0) {
                Text("닉네임")
                    .font(Font.pretendard(size: 16, weight: .bold))
                    .foregroundStyle(Color(UIColor.customGray200))
                
                
                HStack(spacing: 0) {
                    TextField("", text: $joinVM.nickName,
                              prompt: Text("닉네임을 입력해주세요")
                        .foregroundColor(Color(UIColor.customGray400)),
                              axis: .vertical)
                    .addLeftPadding(UIScreen.UIWidth(16))
                    .modifier(LoginTextFieldModifier(width: UIScreen.UIWidth(213), height: UIScreen.UIHeight(48), text: $joinVM.nickName))
                    .limitText($joinVM.nickName, to: 10)
                    .onAppear(perform : UIApplication.shared.hideKeyboard)
                    .onChange(of: joinVM.nickName) { newValue in
                        joinVM.send(action: .updateNicknameStatus(newValue))
                    }
                    .padding(.trailing, UIScreen.UIWidth(10))
                    
                    
                    Button(action: {joinVM.send(action: .duplicateConfirmation)}
                           , label: {
                        CustomText(font: .pretendard, title: "중복확인", textColor: .white, textWeight: .regular, textSize: 16, textAlignment: .leading)
                            .minimumScaleFactor(0.2)
                    })
                    .frame(width: UIScreen.UIWidth(88), height: UIScreen.UIHeight(48))
                    .background(Color(UIColor.customBlue100))
                    .cornerRadius(8)
                }
                .padding(.top, UIScreen.UIHeight(8))
                
                CustomText(font: .pretendard, title: joinVM.nicknameStatus.message, textColor: joinVM.nicknameStatus.color, textWeight: .regular, textSize: 12)
                    .padding(.top, UIScreen.UIHeight(4))
                
                Text("학과")
                    .font(Font.pretendard(size: 16, weight: .bold))
                    .foregroundStyle(Color(UIColor.customGray200))
                    .padding(.top, UIScreen.UIHeight(34))
                
                TextField("", text: $joinVM.departmentName,
                          prompt: Text("학과를 입력해주세요")
                    .foregroundColor(Color(UIColor.customGray400)),
                          axis: .vertical)
                .addLeftPadding(UIScreen.UIWidth(16))
                .modifier(LoginTextFieldModifier(width: UIScreen.UIWidth(311), height: UIScreen.UIHeight(48), text: $joinVM.departmentName))
                .onAppear(perform : UIApplication.shared.hideKeyboard)
                .onChange(of: joinVM.departmentName) { newValue in
                    showSuggestions = true
                }
                .padding(.top, UIScreen.UIHeight(8))
                
                if showSuggestions && !joinVM.departmentName.isEmpty {
                    ScrollView {
                        LazyVStack(alignment:.leading) {
                            ForEach(suggestions.filter({ $0.localizedCaseInsensitiveContains(joinVM.departmentName) }), id: \.self) { suggestion in
                                ZStack {
                                    Button(action: {
                                        joinVM.departmentName = suggestion
                                        showSuggestions = false
                                    }) {
                                        CustomText(font: .pretendard, title: suggestion, textColor: .customGray200, textWeight: .regular, textSize: 16)
                                            .padding(.vertical, UIScreen.UIHeight(6))
                                            .padding(.leading, UIScreen.UIWidth(12))
                                    }
                                }
                                .cornerRadius(8)
                            }
                        }
                        .frame(width:UIScreen.UIWidth(311))
                        .background(Color(UIColor.customGray800))
                        .cornerRadius(8)
                    }
                    .padding(.top, UIScreen.UIHeight(8))
                    .cornerRadius(8)
                }
                
                Spacer()
                    
                Button(action: {
                    joinVM.send(action: .updateUser)
                },label: {
                    CustomText(font: .pretendard, title: "가입하기", textColor: .customGray100, textWeight: .bold, textSize: 18, textAlignment: .leading)
                        .minimumScaleFactor(0.2)
                        .frame(maxWidth: UIScreen.UIWidth(311), minHeight: UIScreen.UIHeight(50))
                        .opacity(allClear ? 1 : 0.5)
                })
                .background(
                    Image(allClear ? .icClearButton: .icButton)
                        .resizable()
                        .cornerRadius(8)
                        .background(
                            RoundedRectangle(cornerRadius: 8.8)
                                .stroke(Color(.customBlue400), lineWidth: 1)
                        )
                )
                .cornerRadius(8.8)
                .disabled(joinVM.nicknameStatus == .available && !joinVM.departmentName.isEmpty ? false : true )
                .padding(.bottom, UIScreen.UIHeight(20))
            }
            .padding(.top, UIScreen.UIHeight(23))
        }
        .customNavigation(left: {
            CustomText(font: .suite, title: "회원가입", textColor: .customGray100, textWeight: .semibold, textSize: 18)
        })
    }
}


struct LoginTextFieldModifier: ViewModifier {
    var width: CGFloat
    var height: CGFloat
    @Binding var text: String
    
    func body(content: Content) -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(UIColor.customGray800))
                .cornerRadius(8)
                .frame(width: width,height: height)
            
            HStack(spacing:0) {
                content
                    .font(Font.pretendard(size: 16, weight: .regular))
                    .textInputAutocapitalization(.never)
                    .frame(width: width - UIScreen.UIWidth(38), height: height)
                    .foregroundColor(Color(UIColor.customGray200))
                    .scaledToFit()
                    .minimumScaleFactor(0.2)
                
                
                Image(.icClear)
                    .foregroundColor(.secondary)
                    .onTapGesture {
                        text = ""
                    }
                    .padding(.trailing, UIScreen.UIWidth(14))
                
            }
        }
    }
}



#Preview {
    JoinView()
}
