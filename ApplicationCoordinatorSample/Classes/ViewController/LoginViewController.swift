//
//  LoginViewController.swift
//  ApplicationCoordinatorSample
//
//  Created by Hiasa, Takahiro on 2017/03/19.
//  Copyright © 2017年 takahia. All rights reserved.
//

import UIKit

protocol LoginTransition: Presentable {
    var onLoginButtonTap:(() -> Void)? { get set }
    var onDismissButtonTap:(() -> Void)? { get set }
}

class LoginViewController: UIViewController, LoginTransition {

    //MARK: Transition
    var onLoginButtonTap:(() -> Void)?
    var onDismissButtonTap:(() -> Void)?
    
    //MARK: Property
    @IBOutlet weak var loginButton: UIButton!

    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "ログイン"
        self.view.backgroundColor = UIColor.white
        
        self.loginButton.setTitle("facebookでログイン",
                                  for: .normal)
        self.loginButton.setTitleColor(UIColor.white,
                                       for: .normal)
        self.loginButton.backgroundColor = UIColor(red: 30/255,
                                                   green: 50/255,
                                                   blue: 97/255,
                                                   alpha: 1.0)
        self.loginButton.addTarget(self,
                                   action: #selector(loginButtonAction(sender:)),
                                   for: .touchUpInside)
        
        let dismissBarButton = UIBarButtonItem(barButtonSystemItem: .stop,
                                               target: self,
                                               action: #selector(dismissBarButtonAction(sender:)))
        self.navigationItem.leftBarButtonItem = dismissBarButton
    }
    
    //MARK: Private Action
    @objc func loginButtonAction(sender: UIButton) {
        self.onLoginButtonTap?()
    }
    
    
    @objc func dismissBarButtonAction(sender: UIBarButtonItem) {
        self.onDismissButtonTap?()
    }
    
}
