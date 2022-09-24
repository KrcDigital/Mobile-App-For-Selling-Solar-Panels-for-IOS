//
//  odeme_page.swift
//  strong_sunny
//
//  Created by Can Kirac on 10.06.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class odeme_page: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        getpakelerim()
        getadres()
        getuserinfo()
        gettegram()

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func kopy(_ sender: Any) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = adres.text
    }
    
    @IBAction func satinaldim(_ sender: Any) {
        createbuy()
    }
    
    @IBOutlet weak var panelname: UILabel!
    
    var panelnamel = "sdf"
    var fiyatl = "0"
    var panelimgl = "sdf"
    var panelucretl = "sdfs"
    var paneloranl = "sdfsdfs"
    var fiyatdouble = 0.0
    var packetid = ""
    @IBOutlet weak var fiyat: UILabel!
    @IBOutlet weak var panelimg: UIImageView!
    @IBOutlet weak var paneloran: UILabel!
    @IBOutlet weak var panelucret: UILabel!
    
    @IBOutlet weak var adres: UILabel!
    

    
    var adress = [String]()
    var k = [String]()
    
    var useridsi = ""
    var bakiyer = ""
    var useridm = ""
    @objc func getuserinfo() {
        

        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("users").whereField("eposta", isEqualTo:  Auth.auth().currentUser?.email).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                    
                  
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            
                            self.bakiyer = doc.get("bakiye") as! String
                            self.useridsi = doc.documentID as String
                            
                        }
                        
                        
                        
                    }

                }
                
                
            }
            
            

        }
        

    }
    @objc func gettegram() {
        

        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("telegram").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                    
                  
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            
                            self.telegramid = doc.get("numara") as! String
                           
                            
                        }
                        
                        
                        
                    }

                }
                
                
            }
            
            

        }
        

    }
    var ptutarr = 0
    
    @objc func getpakelerim() {
        
        
        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("paketlerim").whereField("sahip", isEqualTo: Auth.auth().currentUser?.email).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.ptutarr = 0
                    
                  
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            

                            self.ptutarr = self.ptutarr + Int(doc.get("fiyat") as! String)!
                            
                        }
                        
                        
                        
                    }

                }
                
                
            }
            
            

        }
        

    }
    
    
    
    
    
    
    
    
    
    @objc func getadres() {
        

        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("adresler").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                    
                    self.adress.removeAll()
                    self.k.removeAll()
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            
                            self.adress.append(doc.get("adres") as! String)
                            self.k.append(doc.get("k") as! String)
                           
                            
                        }
                        
                        
                        
                    }

                }
                
                
            }
            var randi = Int.random(in: 0..<self.adress.count)
            self.adres.text = self.adress[randi]

            self.panelname.text = self.panelnamel
            self.panelimg.sd_setImage(with: URL(string: self.panelimgl))
            self.paneloran.text = self.paneloranl
            self.panelucret.text = self.panelucretl
            self.fiyat.text = self.fiyatl + "$"
            

        }
        

    }
    
    
    
    
   
    @objc func createbuy() {
        if Double(ptutarr) + Double(fiyatl)! <= Double(bakiyer)! {
            
        print("hata aldın")

        if Double(bakiyer)! >= Double(fiyatl)! {
            

        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = df.string(from: date)
        let firestore = Firestore.firestore()
        let firestorepacket = ["date":dateString,"durum":"1","sahip":Auth.auth().currentUser?.email,"fiyat":self.fiyatl,"packet_id":self.packetid] as [String : Any]
        
        var firestoreref : DocumentReference?
            firestoreref = firestore.collection("paketlerim").addDocument(data: firestorepacket, completion: { [self] error in
            if error != nil {
                print("hata aldın3")
            }
            else {

               
                
                self.performSegue(withIdentifier: "geri", sender: nil)
            }
        })
            
        }
        
        else{
            self.outtub.setTitleColor(UIColor.red, for: UIControl.State.normal)
            self.outtub.setTitle("Yetersiz Bakiye", for: .normal)
        }
            
        }
        
        else {
            self.outtub.setTitleColor(UIColor.red, for: UIControl.State.normal)
            self.outtub.setTitle("Yetersiz Bakiye", for: .normal)
        }
            
            
        }
    
    var telegramid = ""
    
    @IBAction func telegramm(_ sender: Any) {
        
        
        
        let url = URL(string: "https://t.me/\(telegramid)")
        UIApplication.shared.open(url!)
        
        
        
        
        
    }
    @IBAction func btnoutt(_ sender: Any) {
    }
    
    @IBOutlet weak var outtub: UIButton!
}
