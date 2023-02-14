//
//  AuthCoordinator.swift
//  E-commerce-app
//
//  Created by Shakhzod Azamatjonov on 14/02/23.
//

import Foundation

class AuthCoordinator: Coordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    
    var type: CoordinatorType = .auth
    
    public var children: [Coordinator] = []
    public var router: Router
    private let factory: AuthDependencyAssembler
    
    // MARK: - Initializers
    init(router: Router, factory: AuthDependencyAssembler) {
        self.router = router
        self.factory = factory
    }
    
    public func present(animated: Bool, onDismissed: (() -> Void)?) {
        if let welcomeViewController = factory.makeWelcomeViewController(coordinator: self) {
            router.present(welcomeViewController,
                           animated: true,
                           onDismissed: nil)
        }
    }
}

extension AuthCoordinator: WelcomeDelegate {
    
}
