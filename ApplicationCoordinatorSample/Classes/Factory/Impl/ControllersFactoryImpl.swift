//
//  ControllersFactoryImpl.swift
//  ApplicationCoordinatorSample
//
//  Created by Hiasa, Takahiro on 2017/03/19.
//  Copyright © 2017年 takahia. All rights reserved.
//

import Foundation

class ControllersFactoryImpl: ControllersFactory {
    
    func createTopTransition()
        -> TopTransition {
            let nibName = String(describing: TopViewController.self)
            let topViewController = TopViewController(nibName: nibName, bundle: nil)
            return topViewController
    }
    
    func createLoginTransition()
        -> LoginTransition {
            let nibName = String(describing: LoginViewController.self)
            let loginViewController = LoginViewController(nibName: nibName, bundle: nil)
            return loginViewController
    }
    
    
    func createFoodListTransition()
        -> FoodListTransition {
            let nibName = String(describing: FoodListViewController.self)
            let foodListViewController = FoodListViewController(nibName: nibName, bundle: nil)
            return foodListViewController
    }
    
    func createWebTransition(url: URL)
        -> WebTransition {
            let webViewController = WebViewController()
            webViewController.loadRequest(withURL: url)
            return webViewController
    }
}
