//
//  WebViewController.swift
//  ApplicationCoordinatorSample
//
//  Created by Hiasa, Takahiro on 2017/03/19.
//  Copyright © 2017年 takahia. All rights reserved.
//

import UIKit
import WebKit

protocol WebTransition: Presentable { }

class WebViewController: UIViewController, WebTransition {

    //MARK: Property
    private let webView = WKWebView()
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "お店詳細"
        
        self.view.addSubview(self.webView)
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        let attributes:[NSLayoutAttribute] = [.top, .left, .bottom, .right]
        for attribute in attributes {
            let constraint = NSLayoutConstraint(item: self.webView,
                                               attribute: attribute,
                                               relatedBy: .equal,
                                               toItem: self.view,
                                               attribute: attribute,
                                               multiplier: 1,
                                               constant: 0)
            constraints.append(constraint)
        }
        self.view.addConstraints(constraints)
    }
    
    //MARK: Public Method
    func loadRequest(withURL url: URL) {
        let request = URLRequest(url: url)
        self.webView.load(request)
    }
}
