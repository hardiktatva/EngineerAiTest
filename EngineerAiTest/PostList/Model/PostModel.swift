//
//  PostModel.swift
//  EngineerAiTest
//
//  Created by MAC108 on 08/10/19.
//  Copyright © 2019 Tatvasoft. All rights reserved.
//

import Foundation
import SwiftyJSON

struct PostListModel {
    var name : String
    var createdDate : String
}

struct Post: JSONable, Equatable {
    
    let id          : String!
    let title       : String!
    let createdAt   : String!
    var isActivated : Bool = false
    
    init?(parameter: JSON) {
        id         = parameter["objectID"].stringValue
        title      = parameter["title"].stringValue
        createdAt  = parameter["created_at"].stringValue
    }
    
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title
    }
}
