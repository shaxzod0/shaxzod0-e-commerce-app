//
//  AuthDependencyAssembler.swift
//  E-commerce-app
//
//  Created by Shakhzod Azamatjonov on 14/02/23.
//

import Foundation

class AuthDependencyAssembler {
    static let shared = AuthDependencyAssembler()
    
    private init() {}
    
    lazy var welcomeRepository = WelcomeRepository()
}

extension AuthDependencyAssembler: AuthFactory {
    func makeAuthCoordinator(router: Router, factory: AuthDependencyAssembler) -> AuthCoordinator {
        let coordinator = AuthCoordinator(router: router, factory: factory)
        return coordinator
    }
    
    
}

extension AuthDependencyAssembler: WelcomeFactory {
    func makeWelcomeViewModel() -> WelcomeViewModel {
        let vm = WelcomeViewModel(repository: welcomeRepository)
        return vm
    }
    
    func makeWelcomeViewController(coordinator: AuthCoordinator) -> WelcomeController? {
        let vc = WelcomeController(viewModel: makeWelcomeViewModel(), delegate: coordinator)
        return vc
    }
    
}
