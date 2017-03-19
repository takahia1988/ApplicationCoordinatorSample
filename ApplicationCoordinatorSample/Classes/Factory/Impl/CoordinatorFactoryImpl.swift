//
//  CoordinatorFactoryImpl.swift
//  ApplicationCoordinatorSample
//
//  Created by Hiasa, Takahiro on 2017/03/19.
//  Copyright © 2017年 takahia. All rights reserved.
//

import Foundation
import UIKit

class CoordinatorFactoryImpl: CoordinatorFactory {
    
    func createApplicationCoordinator(window: UIWindow)
        -> ApplicationCoordinator {
            return self.createApplicationCoordinator(window: window,
                                                     navigationController: nil)
    }
    
    func createApplicationCoordinator(window: UIWindow,
                                      navigationController: UINavigationController?)
        -> ApplicationCoordinator {
            let router = self.router(navigationController: navigationController)
            
            return ApplicationCoordinator(window: window,
                                          router: router,
                                          controllersFactory: ControllersFactoryImpl(),
                                          coordinatorFactory: CoordinatorFactoryImpl())
    }
    
    func createLoginCoordinator()
        -> (Coordinator & LoginCoordinatorOutput, UIViewController) {
            return self.createLoginCoordinator(navigationController: nil)
    }
    
    func createLoginCoordinator(navigationController: UINavigationController?)
        -> (Coordinator & LoginCoordinatorOutput, UIViewController) {
            let router = self.router(navigationController: navigationController)
            let loginCoordinator = LoginCoordinator(router: router,
                                                    controllersFactory: ControllersFactoryImpl(),
                                                    coordinatorFactory: CoordinatorFactoryImpl())
            let controller = router.navigatonController
            return (loginCoordinator, controller)
    }
}
