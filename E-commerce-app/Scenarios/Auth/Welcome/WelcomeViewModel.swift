//  
//  WelcomeViewModel.swift
//  E-commerce-app
//
//  Created by Shakhzod Azamatjonov on 14/02/23.
//

import UIKit
import RxSwift

class WelcomeViewModel {
    let disposeBag = DisposeBag()
    let repository: WelcomeRepositoryProtocol?
    
    init(repository: WelcomeRepositoryProtocol) {
        self.repository = repository
    }
}
