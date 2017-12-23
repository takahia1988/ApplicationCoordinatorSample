//
//  DeeplinkCoordinator.swift
//  ApplicationCoordinatorSample
//
//  Created by Takahiro Hiasa on 2017/12/23.
//  Copyright © 2017年 takahia. All rights reserved.
//

import Foundation

protocol DeeplinkCoordinatorOutput {
    var finishFlow: (()->())? { get set }
    var cancelFlow: (()->())? { get set }
}

class DeeplinkCoordinator: Coordinator, DeeplinkCoordinatorOutput {
    
    var childCoordinators: [Coordinator] = []
    var finishFlow: (()->())?
    var cancelFlow: (()->())?
    
    private let router: Router
    private let controllersFactory: ControllersFactory
    private let coordinatorFactory: CoordinatorFactory
    
    //MARK: initializer
    init(router: Router,
         controllersFactory: ControllersFactory,
         coordinatorFactory: CoordinatorFactory) {
        
        self.router = router
        self.controllersFactory = controllersFactory
        self.coordinatorFactory = coordinatorFactory
    }
    
    func start(deeplinkType: DeeplinkType) {
        switch deeplinkType {
        case .login:
            self.showLoginViewCoordinator()
        case .foodlist:
            self.showFoodListView(animated: false)
        case .none:
            return
        }
    }
    
    func cancel() { }
    
    /*
     * Push View Controller
     */
    private func showFoodListView(animated: Bool) {
        let foodListTransition = self.controllersFactory.createFoodListTransition()
        foodListTransition.onCellTap = { [weak self] (url) in
            self?.showWebView(url: url)
        }
        self.router.push(controller: foodListTransition.toPresent(), animated: animated)
    }
    
    private func showWebView(url: URL) {
        let webTransition = self.controllersFactory.createWebTransition(url: url)
        self.router.push(controller: webTransition.toPresent())
    }
    
    /*
     * Present View Controller By Coordinator
     */
    private func showLoginViewCoordinator() {
        let (loginCoordinator, controller) = self.coordinatorFactory.createLoginCoordinator()
        loginCoordinator.finishFlow = { [weak self, weak loginCoordinator] in
            self?.finishFlow?()
            self?.router.dismiss()
            self?.removeChildDependency(coordinator: loginCoordinator)
        }
        
        loginCoordinator.cancelFlow = { [weak self, weak loginCoordinator] in
            self?.finishFlow?()
            self?.router.dismiss()
            self?.removeChildDependency(coordinator: loginCoordinator)
        }
        
        self.addChildDependency(coordinator: loginCoordinator)
        loginCoordinator.start()
        self.router.present(controller: controller)
    }
}
