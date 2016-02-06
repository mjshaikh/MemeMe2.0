//
//  MemeTableViewCell.swift
//  MemeMe2.0
//
//  Created by Mohammed Shaikh on 2015-12-12.
//  Copyright © 2015 Zaytun Lab. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
