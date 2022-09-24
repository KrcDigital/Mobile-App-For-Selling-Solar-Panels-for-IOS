//
//  admin_users.swift
//  strong_sunny
//
//  Created by Can Kirac on 13.06.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class admin_users: UIViewController , UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return email.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablee.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! refcel
        cell.email.text = email[indexPath.row]
        cell.kullaniciadi.text = kullaniciadi[indexPath.row]
        cell.sayac.text = numara[indexPath.row]
        
        
        
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        tablee.dataSource = self
        tablee.delegate = self
        getusers()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var tablee: UITableView!
    
    var email = [String]()
    var kullaniciadi = [String]()
    var numara = [String]()
    var useridsi = [String]()
    var bakiye = [String]()
    
    
    var sayac = 0
    @objc func getusers() {
        


        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("users").order(by: "username").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{

                    self.email.removeAll()
                    self.kullaniciadi.removeAll()
                    self.numara.removeAll()
                    self.useridsi.removeAll()
                    self.sayac = 0
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            
                            self.sayac = self.sayac + 1
                            self.email.append(doc.get("eposta") as! String)
                           
                            self.kullaniciadi.append(doc.get("username") as! String)
                            self.numara.append("\(self.sayac)")
                            self.useridsi.append(doc.documentID as! String)
                            self.bakiye.append(doc.get("bakiye") as! String)
                        }
                        
                        
                        
                    }

                }
                
                
            }
            self.tablee.reloadData()
            
            

        }
        

    }
    @IBOutlet weak var bakiyein: UIView!
    
    @IBAction func baiino(_ sender: Any) {
    }
    @IBOutlet weak var usernamelbl: UILabel!
    @IBAction func bakiyeinn(_ sender: Any) {
    }
    @IBAction func bakiinout(_ sender: Any) {
    }
    @IBOutlet weak var bakinor: UITextField!
    
    @IBAction func kapa(_ sender: Any) {
        backview.isHidden = true
    }
    @IBOutlet weak var backview: UIView!
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        self.backview.isHidden = false
        self.usernamelbl.text = kullaniciadi[indexPath.row]
        self.bakinor.text = "\(bakiye[indexPath.row])"
        self.idim = useridsi[indexPath.row]
        
        
    }
    var idim = ""
    
    
    @IBAction func upla(_ sender: Any) {
        let firestoredb = Firestore.firestore()
        let newnote = ["bakiye":self.bakinor.text!] as [String : Any]
        firestoredb.collection("users").document(idim).setData(newnote, merge: true)
        backview.isHidden = true
    }
}
