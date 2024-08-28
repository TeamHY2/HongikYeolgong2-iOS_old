//
//  SplashView.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/8/24.
//

import SwiftUI

struct SplashView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard = UIStoryboard(name: "Launch Screen", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()!
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

