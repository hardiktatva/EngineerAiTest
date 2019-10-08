//
//  Response.swift
//  EngineerAiTest
//
//  Created by MAC108 on 08/10/19.
//  Copyright © 2019 Tatvasoft. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Response {
    var status      : Bool!
    var data        : Any!
    
    init() {
        status     = false
        data       = nil
    }
    
    init<T>(parameter: JSON, dataKey: String?, type: T? = nil) {
        status     = true
        if let t = type, let key = dataKey, let d = parameter[key].to(type: t) {
            data = d
        } else {
            data = parameter
        }
    }
    
    static var noInternetResponse: Response {
        var response        = Response()
        response.status     = false
        response.data       = nil
        return response
    }
}
