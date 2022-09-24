//
//  referanslarim.swift
//  strong_sunny
//
//  Created by Can Kirac on 10.06.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore


class referanslarim: UIViewController , UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totallbl.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablee.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! refcel
        cell.kullaniciadi.text = kullaniciadi[indexPath.row]
        cell.tutarlbl.text = "Paket Tutarı: (\(totallbl[indexPath.row]) $)"
        
        
        
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tablee.delegate = self
        tablee.dataSource = self
        
        getcodem()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var refadet: UILabel!
    
    @IBOutlet weak var refkazanc: UILabel!
    
    @IBOutlet weak var tablee: UITableView!
    @IBOutlet weak var refcode: UILabel!
    
    var codem = ""
    var sayac = 1
    
    var kullaniciadi = [String]()
    var email = [String]()
    var numara = [String]()
    
    
    @objc func getref(codes : String) {
        


        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("referanslar").whereField("code", isEqualTo: codes).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.kullaniciadi.removeAll()
                    
                   
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            self.kullaniciadi.append(doc.get("kullanici") as! String)
                            
                            self.numara.append("\(self.sayac)")
                            self.getyatirim(idsi: doc.get("user_email") as! String)
                           
                           
                            
                        }
                        
                        
                        
                    }

                }
        
                
            }
            self.refadet.text = "\(self.sayac - 1)"
            self.tablee.reloadData()

        }
        

    }
    
    @IBAction func kopy(_ sender: Any) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = refcode.text
    }
    
    @objc func getcodem() {
        


        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("users").whereField("eposta", isEqualTo: Auth.auth().currentUser?.email as! String).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                   
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            self.codem = doc.get("codem") as! String
                            self.getref(codes: self.codem)
                           
                           
                            
                        }
                        
                        
                        
                    }

                }
        
        
            }

            self.refcode.text = self.codem
            
        }

    }
    
    var totalyatirim = 0
    
    @objc func getyatirim(idsi : String) {
        
        totalyatirim = 0

        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("paketlerim").whereField("sahip", isEqualTo: Auth.auth().currentUser?.email as! String).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{

                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            
                            self.totalyatirim = self.totalyatirim + Int(doc.get("fiyat") as! String)!
                            
                            
                        }
                        
                        
                        
                    }

                }
                
                
            }
            self.totallbl.append("\(self.totalyatirim)")
            self.tablee.reloadData()

        }
        

    }
    var totallbl = [String]()
    
}
