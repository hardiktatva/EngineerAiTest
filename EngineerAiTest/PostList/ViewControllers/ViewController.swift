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

    }
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.viewModel.pageNumber = 1
        self.viewModel.getPostList(page:self.viewModel.pageNumber)
    }
    
    private func setupBinding() {
        let postlist = PostListModel(name: "ad", createdDate: "asd")
        let postlist1 = PostListModel(name: "ad", createdDate: "asd")
        let postlist2 = PostListModel(name: "ad", createdDate: "asd")
        viewModel.postList.accept([postlist,postlist1,postlist2])
        
        viewModel.postList.bind(to: tableViewPostList.rx.items(cellIdentifier: "postCell", cellType: PostListCell.self)) { (_, post: PostListModel, cell) in
            cell.postListModel = post
        }.disposed(by: disposBag)
        
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
            self.navigationItem.title = "selected posts(\(self.viewModel.selectedPost))"
        }
    }
}
