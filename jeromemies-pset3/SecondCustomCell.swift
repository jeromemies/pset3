//
//  SecondCustomCell.swift
//  jeromemies-pset3
//
//  Created by Jerome Mies on 27/02/17.
//  Copyright © 2017 Jerome Mies. All rights reserved.
//

import UIKit

class SecondCustomCell: UITableViewCell {
    @IBOutlet weak var savedList: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
