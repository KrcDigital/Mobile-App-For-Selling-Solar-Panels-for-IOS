//
//  admin_cekme.swift
//  strong_sunny
//
//  Created by Can Kirac on 14.06.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class admin_cekme: UIViewController , UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return durum.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablee.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! talepcell
        cell.name.text = names[indexPath.row]
        cell.durum.text = durum[indexPath.row]
        
        
        
        
        return cell
    }

    @IBOutlet weak var tablee: UITableView!
    var durum = [String]()
    var names = [String]()
    var kullanıcı = [String]()
    var cüzdan = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func getcekme() {
        
        
        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("cekmetalep").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{

                    self.durum.removeAll()
                    self.names.removeAll()
                    self.kullanıcı.removeAll()
                    self.cüzdan.removeAll()
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            
                            
                            self.names.append("\(doc.get("tutar") as! String) $ Çekme Talebim")
                            self.durum.append(doc.get("durum") as! String)
                            self.cüzdan.append(doc.get("cüzdan") as! String)
                            self.kullanıcı.append(doc.get("sahip") as! String)
                            
                        }
                        
                        
                        
                    }

                }
                
                
            }
            self.tablee.reloadData()
            
            

        }
        
        self.tablee.reloadData()

    }
    

}
