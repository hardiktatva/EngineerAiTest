//
//  PostListInteractor.swift
//  EngineerAiTest
//
//  Created by MAC108 on 08/10/19.
//  Copyright © 2019 Tatvasoft. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON

struct PostsListInteractor {
    
    //MARK:- Webservice Methods
    static func getPosts(page: Int) -> Observable<Response> {
        return Webservice.API.sendRequest(.posts(page))
    }
}

extension JSON {
    
    func to<T>(type: T?) -> Any? {
        if let baseObj = type as? JSONable.Type {
            guard self.type != .null, self.type != .unknown else {
                return nil
            }
            
            if self.type == .array {
                var arrObject: [Any] = []
                arrObject = self.arrayValue.map { baseObj.init(parameter: $0)! }
                return arrObject
            } else {
                let object = baseObj.init(parameter: self)!
                return object
            }
        }
        return nil
    }
}

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
