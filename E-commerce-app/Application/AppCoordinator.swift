//
//  AppCoordinator.swift
//  E-commerce-app
//
//  Created by Shakhzod Azamatjonov on 14/02/23.
//

import UIKit

final class AppCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate? = nil
    var children: [Coordinator] = []
    
    var router: Router
    private let window: UIWindow
    var type: CoordinatorType { .app }
    let networkService = NetworkService()

    init(window: UIWindow) {
        self.window = window
        self.router = AppDelegateRouter(window: window)
    }
    
    func present(animated: Bool, onDismissed: (() -> Void)?) {
        //FIXME: Need implement checking
        showAuthFlow()
    }
    
    func showAuthFlow(){
        let assambler = AuthDependencyAssembler.shared
        let coordinator = assambler.makeAuthCoordinator(router: router, factory: assambler)
        coordinator.finishDelegate = self
        presentChild(coordinator, animated: true, onDismissed: nil)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        children = children.filter({ $0.type != childCoordinator.type })

        switch childCoordinator.type {
        case .auth:
            //FIXME: Need implement navigation
            break
        case .homeTab:
            showAuthFlow()
        default:
            break
        }
    }
    
    
}
