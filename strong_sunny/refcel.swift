//
//  refcel.swift
//  strong_sunny
//
//  Created by Can Kirac on 10.06.2022.
//

import UIKit

class refcel: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var sayac: UILabel!
    
    @IBOutlet weak var tutarlbl: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var kullaniciadi: UILabel!
}
