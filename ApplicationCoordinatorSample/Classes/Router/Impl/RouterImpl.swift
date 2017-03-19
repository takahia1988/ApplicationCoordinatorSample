//
//  RouterImpl.swift
//  ApplicationCoordinatorSample
//
//  Created by Hiasa, Takahiro on 2017/03/19.
//  Copyright © 2017年 takahia. All rights reserved.
//

import Foundation
import UIKit

class RouterImpl: Router {
    
    var navigatonController: UINavigationController
    
    required init(navigatonController: UINavigationController) {
        self.navigatonController = navigatonController
    }
    
    //MARK: present view
    func present(controller: UIViewController?) {
        self.present(controller: controller,
                     animated: true)
    }
    
    func present(controller: UIViewController?, animated: Bool) {
        self.present(controller: controller,
                     animated: animated,
                     completion: nil)
    }
    
    func present(controller: UIViewController?, animated: Bool, completion: (() -> ())?) {
        guard let controller = controller else {
            return
        }
        
        self.navigatonController.present(controller,
                                         animated: animated,
                                         completion: completion)
    }
    
    //MARK: push view
    func push(controller: UIViewController?) {
        self.push(controller: controller, animated: true)
    }
    
    func push(controller: UIViewController?, animated: Bool) {
        guard let controller = controller, controller is UINavigationController == false else {
            assertionFailure("Deprecated push UINavigationController.")
            return
        }
        
        self.navigatonController.pushViewController(controller,
                                                    animated: animated)
    }
    
    //MARK: pop view
    func pop() {
        self.pop(animated: true)
    }
    
    func pop(animated: Bool) {
        self.navigatonController.popViewController(animated: animated)
    }
    
    func popToStackedController(controller: UIViewController) {
        self.popToStackedController(controller: controller, animated: true)
    }
    
    func popToStackedController(controller: UIViewController, animated: Bool) {
        let viewControllers = self.navigatonController.viewControllers
        
        let index = viewControllers.index(of: controller)
        if let theIndex = index {
            let newControllers = viewControllers.enumerated().filter { $0.0 <= theIndex }.map { $0.1 }
            self.setRootControllers(controllers: newControllers, animated: true)
            return
        }
    }
    
    //MARK: dismiss view
    func dismiss() {
        self.dismiss(animated: true)
    }
    
    func dismiss(animated: Bool) {
        self.dismiss(animated: animated, completion: nil)
    }
    
    func dismiss(animated: Bool, completion: (() -> ())?) {
        self.navigatonController.dismiss(animated: animated,
                                         completion: completion)
    }
    
    //MARK: other transition
    func setRootController(controller: UIViewController?) {
        self.setRootController(controller: controller, animated: false)
    }
    
    func setRootController(controller: UIViewController?, animated: Bool) {
        guard let controller = controller else {
            return
        }
        
        self.setRootControllers(controllers: [controller], animated: animated)
    }
    
    func setRootControllers(controllers: [UIViewController]?) {
        self.setRootControllers(controllers: controllers, animated: false)
    }
    
    func setRootControllers(controllers: [UIViewController]?, animated: Bool) {
        guard let controllers = controllers else {
            return
        }
        
        self.navigatonController.setViewControllers(controllers, animated: animated)
    }
    
    func popToRootController(animated: Bool) {
        let _ = self.navigatonController.popToRootViewController(animated: animated)
    }
    
    func removeControllerFromStack(viewController: UIViewController?) {
        let viewControllers = self.navigatonController.viewControllers.filter({ (obj) -> Bool in
            return obj != viewController
        })
        self.navigatonController.viewControllers = viewControllers
    }
}
