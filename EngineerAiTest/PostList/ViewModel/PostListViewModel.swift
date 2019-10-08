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

enum ViewModelState<T> {
    case loading
    case failure(WebError)
    case finish(Bool)
    case success(T)
}


final class PostListViewModel {
    
    let disposeBag = DisposeBag()
    var posts = BehaviorRelay<[Post]>(value: [])
    var state = PublishSubject<ViewModelState<PostListViewModel>>()
    var nextPage: Int = 1

    var postList: BehaviorRelay<[PostListModel]> = .init(value: [])
    var selectedPost:Int = 0
    var pageNumber:Int = 1
    
    func selectPost(index: Int) -> Int {
        var postsTemp = self.posts.value
        postsTemp[index].isActivated = !postsTemp[index].isActivated
        self.posts.accept(postsTemp)
        return postsTemp.filter { $0.isActivated }.count
    }

}

extension PostListViewModel  {

    func getPostList(page:Int) {
        PostsListInteractor.getPosts(page: page).subscribe(onNext: { [weak self] response in
            guard let `self` = self else { return }
            if let posts = response.data as? [Post] {
                self.posts.accept(posts)
                self.state.onNext(.success(self))
                self.pageNumber = self.pageNumber + 1
            } else {
                self.postList.accept([])
                self.state.onNext(.failure(.noData))
            }
            }, onError: { [weak self] error in
                guard let `self` = self else { return }
                self.postList.accept([])
                self.state.onNext(.failure(error as! WebError))
            }, onCompleted: { [weak self] in
                guard let `self` = self else { return }
                self.state.onNext(.finish(false))
        }).disposed(by: disposeBag)
    }
}
