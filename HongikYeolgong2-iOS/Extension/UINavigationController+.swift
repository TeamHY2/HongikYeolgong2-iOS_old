//
//  UINavigationViewController+.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/4/24.
//

import UIKit

extension UINavigationController: UIGestureRecognizerDelegate {
    // 커스텀 네비게이션을 사용하는 경우 제스처가 먹히지 않는 문제방지
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
}
