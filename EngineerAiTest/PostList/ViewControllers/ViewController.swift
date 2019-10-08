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

    @IBOutlet weak var tableViewPostList: UITableView!
    var viewModel = PostListViewModel()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(ViewController.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    // MARK: - Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupBinding()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Custom Method
    private func setupUI() {
        self.tableViewPostList.refreshControl = refreshControl
        tableViewPostList.rx.setDelegate(self).disposed(by: disposBag)
        self.viewModel.getPostList(page: self.viewModel.pageNumber)
        self.navigationItem.title = "selected posts"
    }
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.viewModel.selectedPost = 0
        self.setTitle()
        self.viewModel.pageNumber = 1
        self.viewModel.getPostList(page:self.viewModel.pageNumber)
    }
    
    private func setTitle() {
        self.navigationItem.title = "selected posts(\(self.viewModel.selectedPost))"
    }
    private func setupBinding() {
    
        viewModel.posts.asObservable().bind(to: tableViewPostList.rx.items(cellIdentifier: "postCell", cellType: PostListCell.self)) { (_, post: Post, cell) in
            cell.postListModel = post
        }.disposed(by: disposBag)
        
        
        viewModel.state.subscribe(onNext :{ state in
            switch state {
            case .loading:
                print("laoding")
            case .finish(let finishPaging):
                if finishPaging {
                    
                } else {
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            case .success:
                print("success")
                if self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                }
            }
        }).disposed(by: disposBag)
        
        tableViewPostList.rx.willDisplayCell
            .subscribe(onNext: { cell, indexPath in
                if indexPath.row == self.viewModel.posts.value.count - 3 {
                    self.viewModel.pageNumber += 1
                    self.viewModel.getPostList(page: self.viewModel.pageNumber)
                }
            }).disposed(by: disposBag)
    }
}

extension ViewController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? PostListCell {
            cell.switchAtivate.isOn = !cell.switchAtivate.isOn
            if cell.switchAtivate.isOn {
              self.viewModel.selectedPost += 1
            } else {
                self.viewModel.selectedPost -= 1
            }
            self.viewModel.selectPost(index: indexPath.row)
            self.setTitle()
        }
    }
}
