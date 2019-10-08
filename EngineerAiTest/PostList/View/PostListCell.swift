//
//  PostListCell.swift
//  EngineerAiTest
//
//  Created by MAC108 on 08/10/19.
//  Copyright © 2019 Tatvasoft. All rights reserved.
//

import UIKit

class PostListCell: UITableViewCell {

    @IBOutlet weak var lblPostName: UILabel!
    @IBOutlet weak var lblCreatedDate: UILabel!
    @IBOutlet weak var switchAtivate: UISwitch!
    
    var postListModel: PostListModel? {
        didSet {
            self.lblPostName.text = postListModel?.name
            self.lblCreatedDate.text = postListModel?.createdDate
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
