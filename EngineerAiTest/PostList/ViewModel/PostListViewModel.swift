//
//  PostListViewModel.swift
//  EngineerAiTest
//
//  Created by MAC108 on 08/10/19.
//  Copyright © 2019 Tatvasoft. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


struct PostListViewModel {

    var postList: BehaviorRelay<[PostListModel]> = .init(value: [])
    var selectedPostIndexpath : BehaviorRelay<[IndexPath]> = .init(value: [])
    var selectedPost:Int = 0
    var pageNumber:Int = 1
    func getPostList(page:Int) {
        
    }
}
