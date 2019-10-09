//
//  ViewController.swift
//  EngineerAiTest
//
//  Created by MAC108 on 08/10/19.
//  Copyright © 2019 Tatvasoft. All rights reserved.
//

import UIKit
import RxSwift


class ViewController: BaseViewController {

    @IBOutlet private weak var tableViewPostList: UITableView!
    @IBOutlet private weak var loadingView: UIActivityIndicatorView!
    
    var viewModel = PostListViewModel()
    // MARK: - Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getPostList()
        self.setupBinding()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Custom Method
    private func getPostList() {
        self.viewModel.getPostList(page: self.viewModel.pageNumber)
    }
    
    private func setTitle() {
        self.navigationItem.title = "Total posts(\(self.viewModel.posts.value.count))"
    }
    private func setupBinding() {
    
        viewModel.posts.asObservable().bind(to: tableViewPostList.rx.items(cellIdentifier: "postCell", cellType: PostListCell.self)) { (_, post: Post, cell) in
            cell.postListModel = post
        }.disposed(by: disposBag)
        
        
        viewModel.state.subscribe(onNext :{ state in
            switch state {
            case .loading:
                print("laoding")
                self.loadingView.startAnimating()
            case .finish(let finishPaging):
                if finishPaging {
                    self.loadingView.stopAnimating()
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.loadingView.stopAnimating()
            case .success:
                print("success")
                self.loadingView.stopAnimating()
                self.setTitle()
            }
        }).disposed(by: disposBag)
        
        tableViewPostList.rx.willDisplayCell
            .subscribe(onNext: { cell, indexPath in
                if indexPath.row == self.viewModel.posts.value.count - 2 {
                    self.viewModel.pageNumber += 1
                    self.viewModel.getPostList(page: self.viewModel.pageNumber)
                }
            }).disposed(by: disposBag)
    }
}


