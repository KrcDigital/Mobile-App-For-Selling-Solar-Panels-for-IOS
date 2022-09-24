//
//  giris.swift
//  strong_sunny
//
//  Created by Can Kirac on 8.06.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore


class giris: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            view.addGestureRecognizer(tap)
    }
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var pass: UITextField!
    
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @IBAction func login(_ sender: Any) {
        if email.text != "" && pass.text != "" {
            
        
            Auth.auth().signIn(withEmail: email.text!, password: pass.text!) { authdata, error in
            if error != nil {
                self.makealert(titlein: "Hatalı Giriş", messagein:" Giriş işlemi hatalı tekrar deneyiniz." )
            }
            else{
                self.performSegue(withIdentifier: "main", sender: nil)
            }
         }
        }
        else{
            self.makealert(titlein: "Hatalı Giriş", messagein:" Email ve Şifre boş olamaz." )
        }
    }
    
   
    
    @objc func makealert(titlein:String, messagein:String)
    {
        let alert = UIAlertController.init(title: titlein, message: messagein, preferredStyle: UIAlertController.Style.alert)
        let alertbutton = UIAlertAction.init(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(alertbutton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    

}
