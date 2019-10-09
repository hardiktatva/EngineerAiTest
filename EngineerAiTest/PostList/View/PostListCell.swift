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
    var postListModel: Post? {
        didSet {
            self.lblPostName.text = postListModel?.title
            self.lblCreatedDate.text = DateHelper.dateInFormate(date: postListModel?.createdAt ?? "")
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
