//
//  AuthFactory.swift
//  E-commerce-app
//
//  Created by Shakhzod Azamatjonov on 14/02/23.
//

import Foundation

protocol AuthFactory {
    func makeAuthCoordinator(router: Router, factory: AuthDependencyAssembler) -> AuthCoordinator
}
