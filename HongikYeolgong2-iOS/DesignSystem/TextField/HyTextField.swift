//
//  CustomTextField.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/28/24.
//

import SwiftUI

struct HyTextField: View {    
    @Binding var text: String
    @FocusState var isFocused: Bool
    
    let placeholder: String
    var isError: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 48)
                .foregroundColor(.gray800)
                .cornerRadius(8)
            
            HStack {
                TextField(text: $text) {
                    Text(placeholder)
                        .font(.pretendard(size: 16, weight: .regular))
                        .foregroundStyle(.gray400)                        
                }
                .focused($isFocused)
                .foregroundColor(.gray200)
                .padding(.leading, 16)
                .padding(.trailing, 8)
                
                if !text.isEmpty {
                    Image(.icClear)
                        .padding(.trailing, 14)
                        .onTapGesture {
                            text = ""
                        }
                }
            }
        }        
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(isError && !text.isEmpty ? .yellow100 : .gray400)
                .opacity(isFocused ? 1 : 0)
        )
    }
}
