//
//  Coordinator.swift
//  ApplicationCoordinatorSample
//
//  Created by Hiasa, Takahiro on 2017/03/19.
//  Copyright © 2017年 takahia. All rights reserved.
//

import Foundation

protocol Coordinator: class {
    
    var childCoordinators:[Coordinator] { get set }
    
    func start()
    func start(deeplinkType: DeeplinkType)
    func cancel()
    func cancelAllChildCoordinator()
    func addChildDependency(coordinator: Coordinator)
    func removeChildDependency(coordinator: Coordinator?)
}

extension Coordinator {
    
    func start() {
        self.start(deeplinkType: .none)
    }
    
    func cancelAllChildCoordinator() {
        self.childCoordinators.forEach { (coordinator) in
            coordinator.cancelAllChildCoordinator()
            coordinator.cancel()
        }
    }
    
    func addChildDependency(coordinator: Coordinator) {
        
        for element in self.childCoordinators {
            if element === coordinator { return }
        }
        self.childCoordinators.append(coordinator)
    }
    
    func removeChildDependency(coordinator: Coordinator?) {
        guard self.childCoordinators.isEmpty == false, let coordinator = coordinator else {
            return
        }
        
        for (index, element) in self.childCoordinators.enumerated() {
            if element === coordinator {
                self.childCoordinators.remove(at: index)
                break
            }
        }
    }
}

