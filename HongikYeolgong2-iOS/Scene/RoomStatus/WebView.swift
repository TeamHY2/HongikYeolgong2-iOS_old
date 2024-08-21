//
//  WebView.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/15/24.
//

import SwiftUI
import WebKit

import SwiftUI
import WebKit

struct MyWebView: UIViewRepresentable {
    var url: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: UIViewRepresentableContext<MyWebView>) {
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    // Coordinator 생성
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // Coordinator 클래스
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: MyWebView

        init(_ parent: MyWebView) {
            self.parent = parent
        }
        
        // 페이지가 로드 완료되면 호출되는 델리게이트 메서드
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            if parent.url == Constants.Url.roomStatus {
                let jsCode = """
                document.body.style.backgroundColor = '#0C0D11';  // 배경색 변경        
                let trElements = document.querySelectorAll('tr');
                let firstTrElement = trElements[0];
                
                firstTrElement.style.color = '#ffffff';
                
                """
                
                webView.evaluateJavaScript(jsCode) { (result, error) in
                    if let error = error {
                        print("JavaScript Error: \(error)")
                    } else {
                        print("Style change applied successfully")
                    }
                }
            }
        }
    }
}
