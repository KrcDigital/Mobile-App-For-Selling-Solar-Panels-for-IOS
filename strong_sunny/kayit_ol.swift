//
//  kayit_ol.swift
//  strong_sunny
//
//  Created by Can Kirac on 8.06.2022.
//

import UIKit

import Firebase
import  FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class kayit_ol: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let klavye = UITapGestureRecognizer(target: self, action: #selector(klavyekaldir))
        view.addGestureRecognizer(klavye)
        // Do any additional setup after loading the view.
    }
    @objc func klavyekaldir() {
        view.endEditing(true)
    }
    
    
    
    
    
    @IBAction func signup(_ sender: Any) {
        if email.text != "" && pass.text != "" {
            Auth.auth().createUser(withEmail: email.text!, password: pass.text!) { authdata, error in
                if error != nil {
                    self.makealert(titlein: "Hatalı Kayıt", messagein: error?.localizedDescription ?? "Kayıt Olma Başarısız.")
                }
                else {
                    
                    
                    
                    let firestore = Firestore.firestore()
                    let firestorepacket = ["user":self.email.text,"username":"0" ] as [String : Any]
                    
                    var firestoreref : DocumentReference?
                    firestoreref = firestore.collection("users").addDocument(data: firestorepacket, completion: { error in
                        if error != nil {
                            print("hata aldın")
                        }
                        else {
                            self.performSegue(withIdentifier: "tomainvc", sender: nil)
                            
                        }
                    })
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
            }
            
        }
        else {
            self.makealert(titlein: "Hatalı Kayıt", messagein: "Mail ve Şifre boş olamaz")
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
