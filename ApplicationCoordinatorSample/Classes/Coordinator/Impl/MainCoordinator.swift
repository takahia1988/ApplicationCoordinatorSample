//
//  MainCoordinator.swift
//  ApplicationCoordinatorSample
//
//  Created by Takahiro Hiasa on 2017/12/23.
//  Copyright © 2017年 takahia. All rights reserved.
//

import UIKit

protocol MainCoordinatorOutput: class {
    var finishFlow: (()->())? { get set }
    var cancelFlow: (()->())? { get set }
}

class MainCoordinator: Coordinator, MainCoordinatorOutput {
    
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
        self.showTopViewController()
    }

    func cancel() {
        self.cancelFlow?()
    }
    
    /*
     * Top View Controller
     */
    private func showTopViewController() {
        
        let topTransition = self.controllersFactory.createTopTransition()
        topTransition.onTopButtonTap = { [weak self] in
            self?.showLoginViewCoordinator()
        }
        
        topTransition.onBottomButtonTap = { [weak self] in
            self?.showFoodListView()
        }
        
        self.router.setRootController(controller: topTransition.toPresent())
    }
    
    /*
     * Push View Controller
     */
    private func showFoodListView() {
        let foodListTransition = self.controllersFactory.createFoodListTransition()
        foodListTransition.onCellTap = { [weak self] (url) in
            self?.showWebView(url: url)
        }
        self.router.push(controller: foodListTransition.toPresent())
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
            self?.router.dismiss()
            self?.removeChildDependency(coordinator: loginCoordinator)
        }
        
        loginCoordinator.cancelFlow = { [weak self, weak loginCoordinator] in
            self?.router.dismiss()
            self?.removeChildDependency(coordinator: loginCoordinator)
        }
        
        self.addChildDependency(coordinator: loginCoordinator)
        loginCoordinator.start()
        self.router.present(controller: controller)
    }
    
    
}
