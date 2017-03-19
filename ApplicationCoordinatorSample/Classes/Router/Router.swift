//
//  Router.swift
//  ApplicationCoordinatorSample
//
//  Created by Hiasa, Takahiro on 2017/03/19.
//  Copyright © 2017年 takahia. All rights reserved.
//

import Foundation
import UIKit

protocol Router: class {
    var navigatonController: UINavigationController { get }
    
    init(navigatonController: UINavigationController)
    
    func present(controller: UIViewController?)
    func present(controller: UIViewController?, animated: Bool)
    func present(controller: UIViewController?, animated: Bool, completion: (() -> ())?)
    
    func push(controller: UIViewController?)
    func push(controller: UIViewController?, animated: Bool)
    
    func pop()
    func pop(animated: Bool)
    func popToStackedController(controller: UIViewController)
    func popToStackedController(controller: UIViewController, animated: Bool)
    
    func dismiss()
    func dismiss(animated: Bool)
    func dismiss(animated: Bool, completion: (() -> ())?)
    
    func setRootController(controller: UIViewController?)
    func setRootController(controller: UIViewController?, animated: Bool)
    func setRootControllers(controllers: [UIViewController]?)
    func setRootControllers(controllers: [UIViewController]?, animated: Bool)
    func popToRootController(animated: Bool)
    
    func removeControllerFromStack(viewController: UIViewController?)
}
