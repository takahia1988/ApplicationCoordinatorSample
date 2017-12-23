//
//  CoordinatorFactory.swift
//  ApplicationCoordinatorSample
//
//  Created by Hiasa, Takahiro on 2017/03/19.
//  Copyright © 2017年 takahia. All rights reserved.
//

import Foundation
import UIKit

protocol CoordinatorFactory {
    func createApplicationCoordinator(window: UIWindow)
        -> ApplicationCoordinator
    
    func createMainCoordinator(router: Router)
        -> MainCoordinator
    
    func createDeeplinkCoordinator(router: Router)
        -> DeeplinkCoordinator
    
    func createApplicationCoordinator(window: UIWindow,
                                      navigationController: UINavigationController?)
        -> ApplicationCoordinator
    
    func createLoginCoordinator()
        -> (Coordinator & LoginCoordinatorOutput, UIViewController)
    
    func createLoginCoordinator(navigationController: UINavigationController?)
        -> (Coordinator & LoginCoordinatorOutput, UIViewController)
}

extension CoordinatorFactory {
    func router(navigationController: UINavigationController?)
        -> Router {
            let navigationController = self.navigationController(navigationController: navigationController)
            return RouterImpl(navigatonController: navigationController)
    }
    
    func navigationController(navigationController: UINavigationController?)
        -> UINavigationController {
            if let navigationController = navigationController {
                return navigationController
            } else {
                let navigationController = UINavigationController()
                navigationController.modalPresentationStyle = .overCurrentContext
                navigationController.modalTransitionStyle = .crossDissolve
                return navigationController
            }
    }
    
}
