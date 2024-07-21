//
//  ViewModelType.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/21/24.
//

import Foundation
import Combine

protocol ViewModelType: ObservableObject  {
    associatedtype Action
    func send(action: Action)
}
