//
//  Coordinators.swift
//  E-commerce-app
//
//  Created by Shakhzod Azamatjonov on 14/02/23.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
   var children: [Coordinator] {get set}
   var router: Router {get}
   var finishDelegate: CoordinatorFinishDelegate? { get set }
   var type: CoordinatorType { get }

   func present(animated: Bool, onDismissed: (() -> Void)?)
   func dismiss(animated: Bool)
   func presentChild(_ child: Coordinator,
                     animated: Bool,
                     onDismissed: (()->Void)?)
}

extension Coordinator {
    private func removeChild(_ child: Coordinator) {
        guard let index = children.firstIndex(where: { $0 === child })
        else { return }
        children.remove(at: index)
    }
    
    public func dismiss(animated: Bool) {
        router.dismiss(animated: true)
    }
    
    public func presentChild(_ child: Coordinator,
                             animated: Bool,
                             onDismissed: (()->Void)?) {
        children.append(child)
        
        child.present(animated: animated,
                      onDismissed: { [weak self, weak child] in
            guard let self = self, let child = child else {
                return
            }
            self.removeChild(child)
            onDismissed?()
        })
    }
}
extension Coordinator {
    func finish() {
        children.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}


// MARK: - CoordinatorOutput

/// Delegate protocol helping parent Coordinator know when its child is ready to be finished.
protocol CoordinatorFinishDelegate: class {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}

protocol NavigationCoordinator: Coordinator {
    /**
     Navigation controller
     */
    var navigationController: UINavigationController { get }
}

enum CoordinatorType {
    case app
    case auth
    case homeTab
    case main
}
