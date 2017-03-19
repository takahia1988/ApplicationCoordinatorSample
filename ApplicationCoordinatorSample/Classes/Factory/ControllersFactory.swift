//
//  ControllersFactory.swift
//  ApplicationCoordinatorSample
//
//  Created by Hiasa, Takahiro on 2017/03/19.
//  Copyright © 2017年 takahia. All rights reserved.
//

import Foundation

protocol ControllersFactory {
    func createTopTransition()
        -> TopTransition
    
    func createLoginTransition()
        -> LoginTransition
    
    func createFoodListTransition()
        -> FoodListTransition
    
    func createWebTransition(url: URL)
        -> WebTransition
}
