//
//  AppDelegateRouter.swift
//  E-commerce-app
//
//  Created by Shakhzod Azamatjonov on 14/02/23.
//

import UIKit

public class AppDelegateRouter: Router {
    
    public let window: UIWindow
    var navController = UINavigationController()
    public init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: Router protocol:
    public func present(_ viewController: UIViewController,
                        animated: Bool,
                        onDismissed: (() -> Void)?) {
        navController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
    
    func pushController(vc: UIViewController, animated: Bool = true) {
        navController.pushViewController(vc, animated: animated)
    }
    
   
    
    public func dismiss(animated: Bool) {
        // App delegate contains this Router so it cant be dismissed.
    }
    
    public func setRootViewController(_ viewController: UIViewController) {
       
    }
    
    public func setRootViewController(_ viewController: UIViewController, hideBar: Bool) {
        
    }
}

