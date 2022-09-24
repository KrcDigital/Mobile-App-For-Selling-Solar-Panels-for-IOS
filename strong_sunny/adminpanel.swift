//
//  adminpanel.swift
//  strong_sunny
//
//  Created by Can Kirac on 11.06.2022.
//

import UIKit

class adminpanel: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        panelad.isUserInteractionEnabled = true
        let topanel = UITapGestureRecognizer(target: self, action: #selector(topan))
        panelad.addGestureRecognizer(topanel)
        
        
        ussr.isUserInteractionEnabled = true
        let tous = UITapGestureRecognizer(target: self, action: #selector(tous))
        ussr.addGestureRecognizer(tous)
        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var ussr: UIView!
    @IBOutlet weak var panelad: UIStackView!
    
    @IBAction func sda(_ sender: Any) {
    }
    
    
    @objc func topan() {
        performSegue(withIdentifier: "topanel", sender: nil)
    }
    
    @objc func tous() {
        performSegue(withIdentifier: "touser", sender: nil)
    }
    
}
