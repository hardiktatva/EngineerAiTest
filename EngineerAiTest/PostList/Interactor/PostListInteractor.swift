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


