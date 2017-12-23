//
//  ApplicationCoordinator.swift
//  ApplicationCoordinatorSample
//
//  Created by Hiasa, Takahiro on 2017/03/19.
//  Copyright © 2017年 takahia. All rights reserved.
//

import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {

    private let router: Router
    private let coordinatorFactory: CoordinatorFactory
    
    //MARK: initializer
    init(router: Router,
         coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    //MARK: Coordinator
    var childCoordinators = [Coordinator]()

    func start(deeplinkType: DeeplinkType) {
        switch deeplinkType {
        case .none:
            self.showMainCoordinator(deeplinkType: deeplinkType)
        default:
            self.showDeeplinkCoordinator(deeplinkType: deeplinkType)
        }
    }
    
    func cancel() { }

    /*
     * Main Transition
     */
    private func showMainCoordinator(deeplinkType: DeeplinkType) {
        let coordinator = self.coordinatorFactory.createMainCoordinator(router: self.router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeChildDependency(coordinator: coordinator)
        }
        coordinator.cancelFlow = { [weak self, weak coordinator] in
            self?.removeChildDependency(coordinator: coordinator)
        }
        self.addChildDependency(coordinator: coordinator)
        coordinator.start(deeplinkType: deeplinkType)
    }
    
    /*
     * Deeplink Transition
     */
    private func showDeeplinkCoordinator(deeplinkType: DeeplinkType) {
        self.cancelAllChildCoordinator()
        let coordinator = self.coordinatorFactory.createDeeplinkCoordinator(router: self.router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.showMainCoordinator(deeplinkType: deeplinkType)
            self?.removeChildDependency(coordinator: coordinator)
        }
        self.addChildDependency(coordinator: coordinator)
        coordinator.start(deeplinkType: deeplinkType)
    }
}


