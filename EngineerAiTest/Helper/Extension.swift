//
//  Extension.swift
//  EngineerAiTest
//
//  Created by MAC108 on 08/10/19.
//  Copyright © 2019 Tatvasoft. All rights reserved.
//

import Foundation
import SwiftyJSON

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
