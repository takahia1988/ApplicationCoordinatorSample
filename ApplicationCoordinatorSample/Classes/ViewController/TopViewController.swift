//
//  TopViewController.swift
//  ApplicationCoordinatorSample
//
//  Created by Hiasa, Takahiro on 2017/03/19.
//  Copyright © 2017年 takahia. All rights reserved.
//

import UIKit

protocol TopTransition: Presentable {
    var onTopButtonTap:(() -> Void)? { get set }
    var onBottomButtonTap:(() -> Void)? { get set }
}

class TopViewController: UIViewController, TopTransition {
    
    //MARK: Transition
    var onTopButtonTap:(() -> Void)?
    var onBottomButtonTap:(() -> Void)?
    
    //MARK: Property
    @IBOutlet private weak var topButton: UIButton!
    @IBOutlet private weak var bottomButton: UIButton!
    
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "TOP"
        self.view.backgroundColor = UIColor.white
        self.setSubViewData()
    }
    
    //MARK: private method
    private func setSubViewData() {
        self.topButton.setTitle("ログイン", for: .normal)
        self.topButton.titleLabel?.textColor = UIColor.brown
        self.topButton.addTarget(self,
                                 action: #selector(topButtonAction(sender:)),
                                 for: .touchUpInside)
        
        self.bottomButton.setTitle("お店リスト", for: .normal)
        self.bottomButton.titleLabel?.textColor = UIColor.brown
        self.bottomButton.addTarget(self,
                                    action: #selector(bottomButtonAction(sender:)),
                                    for: .touchUpInside)
        
    }
    
    //MARK: private Action
    @objc private func topButtonAction(sender: UIButton) {
        self.onTopButtonTap?()
    }
    
    @objc private func bottomButtonAction(sender: UIButton) {
        self.onBottomButtonTap?()
    }
    
}
