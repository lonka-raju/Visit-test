//
//  ChildTableCell.swift
//  Visitation
//
//  Created by Quadrant Apple on 12/20/19.
//  Copyright © 2019 Quadrant. All rights reserved.
//

import UIKit

class ChildTableCell: UITableViewCell {

    @IBOutlet var childNumber:UILabel!
    @IBOutlet var childName:UITextField!
    @IBOutlet var childDateLbl:UILabel!
    @IBOutlet var dateBtn:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
