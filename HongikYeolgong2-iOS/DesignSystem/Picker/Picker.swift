//
//  Picker.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/28/24.
//

import SwiftUI

struct Picker: View {
    @State private var contentSize: CGFloat = 0
    
    @Binding var text: String
    @Binding var seletedItem: String
    @FocusState var isFocused: Bool
    
    let placeholder: String
    let items: [String]
    
    var filterdItem: [String] {
        items.filter { $0.contains(text)}
    }
    
    var isEmpty: Bool {
        !text.isEmpty && filterdItem.count > 0
    }
    
    var contentHeight: CGFloat {
        (contentSize + 1) * CGFloat(filterdItem.count)
    }
    
    var maxHeight: CGFloat {
        (contentSize + 1) * 3
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
            
            // scrollView
            if (isFocused && isEmpty) || (isFocused && text.isEmpty) {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(isFocused && text.isEmpty ? items : filterdItem, id: \.self) { item in
                            Button(action: {
                                seletedItem = item
                                text = item
                                isFocused = false
                            }, label: {
                                Text("\(item)")
                                    .font(.pretendard(size: 16, weight: .regular))
                                    .foregroundStyle(.gray200)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(12)
                            })
                            .overlay (
                                GeometryReader { g in
                                    Color.clear.onAppear {
                                        contentSize = g.size.height
                                    }
                                }
                            )
                        }
                    }
                }
                .frame(maxHeight: filterdItem.count > 0 ? min(contentHeight, maxHeight) : maxHeight)
                .background(.gray800)
                .cornerRadius(8)
            }
        }
        
    }
}
