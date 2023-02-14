//
//  NavigationRouter.swift
//  E-commerce-app
//
//  Created by Shakhzod Azamatjonov on 14/02/23.
//

import Foundation
import UIKit

public class NavigationRouter: NSObject {
    public let navigationController: UINavigationController
    private var routerRootController: UIViewController?
    private var onDismissForViewController: [UIViewController: (() -> Void)] = [:]
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.routerRootController = navigationController.viewControllers.first
        super.init()
        navigationController.delegate = self
    }
    
    
    func getRouterRootController() -> UIViewController? {
        return routerRootController
    }
}

// to call the on-dismiss action if the user presses the back button
extension NavigationRouter: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController,
                                     animated: Bool) {
        guard let dismissedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
              !navigationController.viewControllers.contains(dismissedViewController) else {
            return
        }
        performOnDismissed(for: dismissedViewController)
    }
}

extension NavigationRouter: Router {
    
    private func performOnDismissed(for viewController: UIViewController){
        guard let onDismiss = onDismissForViewController[viewController] else {
            return
        }
        onDismiss()
        onDismissForViewController[viewController] = nil
    }
    
    // MARK: Router protocol:
    public func present(_ viewController: UIViewController,
                        animated: Bool,
                        onDismissed: (() -> Void)?) {
        onDismissForViewController[viewController] = onDismissed
        navigationController.pushViewController(viewController,
                                                animated: animated)
    }
    
    public func dismiss(animated: Bool) {
        guard let routerRootController = routerRootController else {
            navigationController.popToRootViewController(animated: animated)// We need poptoroot function
            return
        }
        performOnDismissed(for: routerRootController)
        navigationController.popViewController(animated: animated)
    }
    
    public func setRootViewController(_ viewController: UIViewController) {
        setRootViewController(viewController, hideBar: false)
    }
    
    public func setRootViewController(_ viewController: UIViewController, hideBar: Bool){
        routerRootController = viewController
        navigationController.setViewControllers([viewController], animated: false)
        navigationController.isNavigationBarHidden = hideBar
    }
}
