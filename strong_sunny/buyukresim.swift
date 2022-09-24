//
//  buyukresim.swift
//  strong_sunny
//
//  Created by Can Kirac on 15.06.2022.
//

import UIKit
import SDWebImage

class buyukresim: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        reismm.sd_setImage(with: URL(string: urlll))
        // Do any additional setup after loading the view.
    }
    
var urlll = ""
    @IBOutlet weak var reismm: UIImageView!
    

}
