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

class kayit: UIViewController {

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
    
    @IBOutlet weak var referans: UITextField!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!
    
    @IBOutlet weak var adres: UITextField!
    @IBOutlet weak var telefon: UITextField!
    @IBOutlet weak var username: UITextField!
    
    
    
    @IBAction func signup(_ sender: Any) {
        var randi = Int.random(in: 100000000..<999999999)

        var newrandi = "\(randi)"
        
        if email.text != "" && pass.text != "" {
            Auth.auth().createUser(withEmail: email.text!, password: pass.text!) { authdata, error in
                if error != nil {
                    self.makealert(titlein: "Hatalı Kayıt", messagein: error?.localizedDescription ?? "Kayıt Olma Başarısız.")
                }
                else {
                    
                    
                    
                    let firestore = Firestore.firestore()
                    let firestorepacket = ["username":self.username.text,"sifre":self.pass.text,"eposta":self.email.text,"referans" : self.referans.text,"codem" : newrandi,"bakiye":"0","admin":0,"cüzdan":self.adres.text] as [String : Any]
                    
                    var firestoreref : DocumentReference?
                    firestoreref = firestore.collection("users").addDocument(data: firestorepacket, completion: { error in
                        if error != nil {
                            print("hata aldın")
                        }
                        else {
                            self.ekle()
                            self.performSegue(withIdentifier: "main", sender: nil)
                            
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

    
    
    @objc func ekle() {
        
        

                            
                            let firestore = Firestore.firestore()
        let firestorepacket = ["code":self.referans.text,"kullanici":self.username.text,"user_email":self.email.text] as [String : Any]
                            
                            var firestoreref : DocumentReference?
                            firestoreref = firestore.collection("referanslar").addDocument(data: firestorepacket, completion: { error in
                                if error != nil {
                                    print("hata aldın")
                                }
                                else {

                                }
                            })
        
        
    }
    

}
