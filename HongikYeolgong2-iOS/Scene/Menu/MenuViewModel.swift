//
//  MenuViewModel.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/3/24.
//

import SwiftUI
import WebKit

class MenuViewModel: ObservableObject {
    @Published var title = "Menu ViewModel"
}

struct WebView2: UIViewRepresentable {
    
    var url: URL?
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = url {
            
            let request = URLRequest(url: url)
            uiView.load(request)
            
        }
    }
}

struct WebViewWithCloseButton: View {
    @Environment(\.presentationMode) var presentationMode
    let url: URL
    
    var body: some View {
        NavigationView {
            WebView2(url: url)
                .navigationBarItems(leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image("ic_back")
                })
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
