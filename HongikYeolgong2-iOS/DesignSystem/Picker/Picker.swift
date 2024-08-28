//
//  Picker.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/28/24.
//

import SwiftUI

struct Picker: View {
    
    @Binding var text: String
    @Binding var seletedItem: String
    @FocusState var isFocused: Bool
    
    let placeholder: String
    let items: [String]
    
    var filterdItem: [String] {
        items.filter { $0.contains(text)}
    }
    var body: some View {
        VStack(spacing: 8) {
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
                    .stroke(.gray400)
                    .opacity(isFocused ? 1 : 0)
            )
            
            if !text.isEmpty && isFocused {
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(filterdItem, id: \.self) { item in
                            Text("\(item)")
                                .font(.pretendard(size: 16, weight: .regular))
                                .foregroundStyle(.gray200)
                                .padding(.leading, 12)
                                .padding(.vertical, 12)
                                .onTapGesture {
                                    seletedItem = item
                                    text = item
                                    isFocused = false
                                }
                        }
                    }
                    .background(.gray800)
                    .cornerRadius(8)
                }
            }
        }
        
    }
}
