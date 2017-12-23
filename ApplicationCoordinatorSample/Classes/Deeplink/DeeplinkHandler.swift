//
//  DeeplinkHandler.swift
//  ApplicationCoordinatorSample
//
//  Created by Takahiro Hiasa on 2017/12/22.
//  Copyright © 2017年 takahia. All rights reserved.
//

import Foundation

class DeeplinkHandler {
    
    class func deeplinkType(with url: URL) -> DeeplinkType {
        guard let host = url.host else { return .none }
        return DeeplinkType(rawValue: host) ?? .none
    }
}
