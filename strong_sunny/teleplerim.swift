//
//  teleplerim.swift
//  strong_sunny
//
//  Created by Can Kirac on 14.06.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage


class teleplerim: UIViewController  , UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return durum.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablee.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! talepcell
        cell.name.text = tutar[indexPath.row]
        cell.durum.text = durum[indexPath.row]
        
        
        
        
        return cell
    }
    @IBOutlet weak var min: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getuser()
        getadres()
        
        tablee.delegate = self
        tablee.dataSource = self
        
        pakiyem.isUserInteractionEnabled = true
        let kop = UITapGestureRecognizer(target: self, action: #selector(kopya))
        pakiyem.addGestureRecognizer(kop)

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var txtr: UILabel!
    @IBOutlet weak var pakiyem: UILabel!
    
    @IBOutlet weak var tablee: UITableView!
    
    @IBAction func add_segment_change(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
            case 0:
            self.getcekme()
            self.ne = 0
            self.btnout.setTitle("Çek", for: .normal)
            self.pakiyem.text = "\(baki) $"
            self.pakiyem.font = UIFont(name: pakiyem.font.fontName, size: 41)
            self.minikl.isHidden = false
            self.txtr.text = "Bakiye"



            case 1:
            self.getyatirma()
            self.ne = 1
            self.btnout.setTitle("Yatır", for: .normal)
            self.pakiyem.text = "\(randil)"
            self.pakiyem.font = UIFont(name: pakiyem.font.fontName, size: 13)
            self.minikl.isHidden = true
            self.txtr.text = "Cüzdan Adresi(TRC20)"


            

        default:
            self.getcekme()
            self.ne = 0
            self.btnout.setTitle("Çek", for: .normal)
            self.pakiyem.text = "\(baki) $"
            self.pakiyem.font = UIFont(name: pakiyem.font.fontName, size: 41)
            self.min.isHidden = false
            self.txtr.text = "Cüzdan Adresi(TRC20)"
                   }
        
    }
    
    var idsi = ""
    var cüzdan = ""
    var baki = ""
    @objc func getuser(){
        


        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("users").whereField("eposta", isEqualTo: Auth.auth().currentUser?.email as! String).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{

                    
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            
                            
                            self.pakiyem.text = "\(doc.get("bakiye") as! String) $"
                            self.baki = doc.get("bakiye") as! String
                            self.idsi = doc.documentID as! String
                            
                        }
                        
                        
                        
                    }

                }
                
                
            }
            
            }
            
            
            

        
        

    }
    
    @IBOutlet weak var minikl: UILabel!
    @IBOutlet weak var mini: UILabel!
    @IBAction func kopya() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = pakiyem.text
    }
    
    @IBOutlet weak var btnout: UIButton!
    var ne = 0
    
    @IBOutlet weak var tutarout: UITextField!
    
    @IBAction func cek(_ sender: Any) {
        
        if ne == 0 {
            if Double(tutarout.text!)! >= 10 {
             
        if Double(baki)! >= Double(tutarout.text!)! {
           
                        let firestore = Firestore.firestore()
            let firestorepacket = ["tutar":self.tutarout.text,"durum":"Beklemede","sahip":Auth.auth().currentUser?.email,"cüzdan":self.cüzdan] as [String : Any]
                        
                        var firestoreref : DocumentReference?
                        firestoreref = firestore.collection("cekmetalep").addDocument(data: firestorepacket, completion: { error in
                            if error != nil {
                                print("hata aldın")
                            }
                            else {
                                var newbakiye = Double(self.baki)! - Double(self.tutarout.text!)!
                                let firestoredb = Firestore.firestore()
                                let newnote = ["bakiye":"\(newbakiye)" as! String] as [String : Any]
                                firestoredb.collection("users").document(self.idsi).setData(newnote, merge: true)
                            }
                        })
            
        
                
            }
        else {
            self.tutarout.backgroundColor = UIColor.red
        }
                
            }
            else {
                self.minikl.textColor = UIColor.red
            }
            
        }
        
        
        if ne == 1 {

           
                        let firestore = Firestore.firestore()
            let firestorepacket = ["tutar":self.tutarout.text,"durum":"Beklemede","sahip":Auth.auth().currentUser?.email,"cüzdan":self.cüzdan] as [String : Any]
                        
                        var firestoreref : DocumentReference?
                        firestoreref = firestore.collection("yatirmatalep").addDocument(data: firestorepacket, completion: { error in
                            if error != nil {
                                print("hata aldın")
                            }
                            else {
                                
                            }
                        })
            
        
                        
            
        }
            
            
    }
        
        
        
    
    
    var tutar = [String]()
    var durum = [String]()
    
    @objc func getcekme() {
        
        self.tutar.removeAll()
        self.durum.removeAll()

        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("cekmetalep").whereField("sahip", isEqualTo:  Auth.auth().currentUser?.email).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{

                    self.tutar.removeAll()
                    self.durum.removeAll()
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            
                            
                            self.tutar.append("\(doc.get("tutar") as! String) $ Çekme Talebim")
                            self.durum.append(doc.get("durum") as! String)
                           
                            
                        }
                        
                        
                        
                    }

                }
                
                
            }
            self.tablee.reloadData()
            
            

        }
        
        self.tablee.reloadData()

    }
    
    @objc func getyatirma() {
        
        self.tutar.removeAll()
        self.durum.removeAll()

        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("yatirmatalep").whereField("sahip", isEqualTo:  Auth.auth().currentUser?.email).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{

                    self.tutar.removeAll()
                    self.durum.removeAll()
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            
                          self.durum.append(doc.get("durum") as! String)
                          self.tutar.append("\(doc.get("tutar") as! String) $ Yatırma Talebim")
                            
                        }
                        
                        
                        
                    }

                }
                
                
            }
            self.tablee.reloadData()
            
            

        }
        
        
        
        

    }
    
    @IBOutlet weak var randadres: UILabel!
    
    
    
    
    @objc func getadres() {
        

        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("adresler").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                    
                    self.adress.removeAll()
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            
                            self.adress.append(doc.get("adres") as! String)
                           
                            
                        }
                        
                        
                        
                    }

                }
                
                
            }
            var randi = Int.random(in: 0..<self.adress.count)
            self.randil = self.adress[randi]

            
            

        }
        

    }
    var randil = ""
    var adress = [String]()
    
    
}
