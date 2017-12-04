//
//  kamusTableViewCell.swift
//  kamus inggris indonesia
//
//  Created by abdul fatah on 11/9/17.
//  Copyright © 2017 FatahKhair. All rights reserved.
//

import UIKit

class kamusTableViewCell: UITableViewCell {
    @IBOutlet weak var english: UILabel!
    @IBOutlet weak var indonesia: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
