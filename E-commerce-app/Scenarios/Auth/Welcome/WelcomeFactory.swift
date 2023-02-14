//  
//  WelcomeFactory.swift
//  E-commerce-app
//
//  Created by Shakhzod Azamatjonov on 14/02/23.
//

import UIKit

protocol WelcomeFactory {
    func makeWelcomeViewModel() ->WelcomeViewModel
    func makeWelcomeViewController(coordinator: AuthCoordinator) -> WelcomeController?
}
