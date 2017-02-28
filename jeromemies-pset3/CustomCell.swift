//
//  CustomCell.swift
//  jeromemies-pset3
//
//  Created by Jerome Mies on 24/02/17.
//  Copyright © 2017 Jerome Mies. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    //@IBOutlet weak var savedList: UILabel!
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var filteredCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
