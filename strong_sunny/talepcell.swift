//
//  talepcell.swift
//  strong_sunny
//
//  Created by Can Kirac on 14.06.2022.
//

import UIKit

class talepcell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var durum: UILabel!
    
    @IBOutlet weak var name: UILabel!
}
