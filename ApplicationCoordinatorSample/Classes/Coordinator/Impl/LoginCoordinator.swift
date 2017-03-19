//
//  LoginCoordinator.swift
//  ApplicationCoordinatorSample
//
//  Created by Hiasa, Takahiro on 2017/03/19.
//  Copyright © 2017年 takahia. All rights reserved.
//

import Foundation

protocol LoginCoordinatorOutput: class {
    var finishFlow: (()->())? { get set }
    var cancelFlow: (()->())? { get set }
}

class LoginCoordinator: Coordinator, LoginCoordinatorOutput {
    
    var childCoordinators = [Coordinator]()
    
    var finishFlow: (()->())?
    var cancelFlow: (()->())?
    
    private let router: Router
    private let controllersFactory: ControllersFactory
    private let coordinatorFactory: CoordinatorFactory
    
    init(router: Router,
         controllersFactory: ControllersFactory,
         coordinatorFactory: CoordinatorFactory) {
        
        self.router = router
        self.controllersFactory = controllersFactory
        self.coordinatorFactory = coordinatorFactory
    }
    
    func start() {
        self.showLoginViewController()
    }
    
    func showLoginViewController() {
        let loginTransition = self.controllersFactory.createLoginTransition()
        loginTransition.onLoginButtonTap = { [weak self] in
            self?.finishFlow?()
        }
        
        loginTransition.onDismissButtonTap = { [weak self] in
            self?.cancelFlow?()
        }
        
        self.router.setRootController(controller: loginTransition.toPresent())

    }
}
