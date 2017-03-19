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
    
    var childCoordinators = [Coordinator]()
    
    private let window: UIWindow
    private let router: Router
    private let controllersFactory: ControllersFactory
    private let coordinatorFactory: CoordinatorFactory
    
    init(window: UIWindow,
         router: Router,
         controllersFactory: ControllersFactory,
         coordinatorFactory: CoordinatorFactory) {

        self.window = window
        self.router = router
        self.controllersFactory = controllersFactory
        self.coordinatorFactory = coordinatorFactory
    }
    
    func start() {
        self.showTopViewController()
    }
    
    /*
     * Top View Controller
     */
    func showTopViewController() {

        let topTransition = self.controllersFactory.createTopTransition()
        topTransition.onTopButtonTap = { [weak self] in
            self?.showLoginViewCoordinator()
        }

        topTransition.onBottomButtonTap = { [weak self] in
            self?.showFoodListView()
        }
        
        self.router.setRootController(controller: topTransition.toPresent())
        self.window.rootViewController = self.router.navigatonController
        self.window.makeKeyAndVisible()
    }
    
    /*
     * Push View Controller
     */
    func showFoodListView() {
        let foodListTransition = self.controllersFactory.createFoodListTransition()
        foodListTransition.onCellTap = { [weak self] (url) in
            self?.showWebView(url: url)
        }
        self.router.push(controller: foodListTransition.toPresent())
    }
    
    func showWebView(url: URL) {
        let webTransition = self.controllersFactory.createWebTransition(url: url)
        self.router.push(controller: webTransition.toPresent())
    }
    
    /*
     * Present View Controller By Coordinator
     */
    func showLoginViewCoordinator() {
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
