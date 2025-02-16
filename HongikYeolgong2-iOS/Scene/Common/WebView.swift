//
//  WebView.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/15/24.
//

import SwiftUI
import WebKit

struct WebView: View {
    @ObservedObject var model: WebViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(url: String) {
        self.model = WebViewModel(url: url)
    }
    var body: some View {
        LoadingView(isShowing: self.$model.isLoading) {
            WebViewReresentable(viewModel: self.model)
        }
        .customNavigation(center: {
            Text("좌석")
                .font(.pretendard(size: 18, weight: .semibold))
                .foregroundStyle(.gray100)
        }, right: {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(.icClose)
            })
        })
    }
}

class WebViewModel: ObservableObject {
    @Published var url: String
    @Published var isLoading: Bool = true
    
    init (url: String) {
        self.url = url
    }
}

struct WebViewReresentable: UIViewRepresentable {
    @ObservedObject var viewModel: WebViewModel
    let webView = WKWebView()
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self.viewModel)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        private var viewModel: WebViewModel
        
        init(_ viewModel: WebViewModel) {
            self.viewModel = viewModel
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.viewModel.isLoading = false
        }
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<WebViewReresentable>) { }
    
    func makeUIView(context: Context) -> UIView {
        self.webView.navigationDelegate = context.coordinator
        
        if let url = URL(string: self.viewModel.url) {
            self.webView.load(URLRequest(url: url))
        }
        
        return self.webView
    }
}

struct LoadingView<Content>: View where Content: View {
    @Binding var isShowing: Bool
    var content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack(alignment: .center) {
                self.content()
                    .disabled(self.isShowing)
                    .overlay(isShowing ? Color.black : Color.clear)
                
                ActivityIndicatorView(isAnimating: .constant(true), style: .large)
                    .frame(width: geometry.size.width / 2, height: geometry.size.height / 5)
                    .cornerRadius(20)
                    .opacity(self.isShowing ? 1 : 0)
            }
        }
    }
}

struct ActivityIndicatorView: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicatorView>) -> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView(style: style)
        activityIndicatorView.color = .blue100
        return activityIndicatorView
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicatorView>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
