//
//  mainpage.swift
//  strong_sunny
//
//  Created by Can Kirac on 8.06.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore


class mainpage: UIViewController , UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paketname.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablee.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! paket_cell
        cell.name.text = paketname[indexPath.row]
        cell.fiyat.text = "\(paketfiyat[indexPath.row]) $"
        cell.img.sd_setImage(with: URL(string: paketimg[indexPath.row]))
        cell.getiri.text = "%\(paketoran[indexPath.row]) (\(paketgetiri[indexPath.row])$)"
        
        
        
        return cell
    }

    @IBOutlet weak var paketler: UIImageView!
    @IBOutlet weak var panellbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        tablee.delegate = self
        tablee.dataSource = self
     getreed()
        getpaketlerim()
        getuser()
        getgünlükgetiri()
        getbekleyen()
        self.pktsayim.text = "Paket Sayım: 0"
        self.panellbl.text = "Panellerim (0)"
        // Do any additional setup after loading the view.
        tomain.isUserInteractionEnabled = true
        let tom = UITapGestureRecognizer(target: self, action: #selector(tom))
        tomain.addGestureRecognizer(tom)

        
        
        eklemeye.isUserInteractionEnabled = true
        let eke = UITapGestureRecognizer(target: self, action: #selector(eklee))
        eklemeye.addGestureRecognizer(eke)
        // Do any additional setup after loading the view.
    }
    
    @objc func tom() {
        performSegue(withIdentifier: "tom", sender: nil)
    }
    
    @IBOutlet weak var tomain: UIImageView!
    
    @objc func topakete() {
        
        performSegue(withIdentifier: "paket", sender: nil)
        
    }
    
    
    @IBOutlet weak var tablee: UITableView!
    
    var paketidsi = [String]()
    
    var paketdate = [String]()
    
    @objc func getpaketlerim() {
        


        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("paketlerim").whereField("sahip", isEqualTo: Auth.auth().currentUser?.email as! String).whereField("durum", isEqualTo: "1").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{

                    self.paketname.removeAll()
                    self.paketfiyat.removeAll()
                    self.paketimg.removeAll()
                    self.paketoran.removeAll()
                    self.paketgetiri.removeAll()
                    self.havuz.removeAll()
                    self.idsi.removeAll()
                    self.paketsayac = 0
                    self.paketidsi.removeAll()
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            
                            
                            self.paketidsi.append(doc.get("packet_id") as! String)
                            self.getrealpaket(idsii: doc.get("packet_id") as! String)
                            
                        }
                        
                        
                        
                    }

                }
                
                
            }
            
            
            

        }
        

    }
    
    var paketname = [String]()
    var paketfiyat = [String]()
    var paketimg = [String]()
    var paketoran = [String]()
    var paketgetiri = [String]()
    var havuz = [String]()
    var idsi = [String]()
    
    @IBOutlet weak var pktsayim: UILabel!
    var paketsayac = 0
    
    @objc func getrealpaket(idsii : String) {
        


        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("paketler").document(idsii).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            
            else {
                
                
                            
                
                self.paketsayac = self.paketsayac + 1
                self.paketname.append(snapshot!.get("name") as! String)
                self.paketfiyat.append(snapshot!.get("fiyat") as! String)
                        
                self.paketimg.append(snapshot!.get("img") as! String)
                self.paketoran.append(snapshot!.get("oran") as! String)
                self.paketgetiri.append(snapshot!.get("getiri") as! String)
                self.havuz.append(snapshot!.get("havuz") as! String)
                        
                self.gunlukrev = Double(snapshot!.get("getiri") as! String)! + self.gunlukrev

                
                
                
            }
            self.tablee.reloadData()
            self.pktsayim.text = "Paket Sayım: \(self.paketsayac)"
            self.panellbl.text = "Panellerim (\(self.paketname.count))"
            
            self.gunluk.text = "Günlük +\(self.gunlukrev)$"

        }
        

    }
    
    var name = ""
    var bakiyem = ""
    var adminmi = 0
    var codem = ""
    @IBOutlet weak var bakiyelbl: UILabel!
    @IBOutlet weak var namelbl: UILabel!
    
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
                            
                            
                            self.namelbl.text = doc.get("username") as! String
                            self.bakiyelbl.text = "\(doc.get("bakiye") as! String) $"
                            self.adminmi = doc.get("admin") as! Int
                            self.codem = doc.get("codem") as! String
                            
                        }
                        
                        
                        
                    }

                }
                
                
            }
            if self.adminmi == 1 {
                self.adminbtn.isHidden = false
            }
            self.tablee.reloadData()
            self.getrefsayac()
            
            

        }
        

    }
    
    @IBOutlet weak var adminbtn: UIButton!
    
    @IBOutlet weak var topaket: UIStackView!
    
    
    @IBAction func ext(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "outtoin", sender: nil)
        }catch {
            let alert = UIAlertController.init(title: "Hata ! ", message: "Çıkış yapılamadı lütfen tekrar deneyin.", preferredStyle: UIAlertController.Style.alert)
            let alertbutton = UIAlertAction.init(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(alertbutton)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBOutlet weak var reflbl: UILabel!
    var refsayac = 0
    @objc func getrefsayac() {
        


        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("referanslar").whereField("code", isEqualTo: self.codem).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                    self.refsayac = 0
                   
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            
                            self.refsayac = self.refsayac + 1

                           
                           
                            
                        }
                        
                        
                        
                    }

                }
        
                
            }
            self.reflbl.text = "Alt Üyelerim: \(self.refsayac)"
            self.tablee.reloadData()

        }
        

    }
    var datem = String()
     
    
    @objc func getreed() {
        
        self.gunlukrev = 0

        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("paketlerim").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                   

                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            

                            if doc.get("sahip") as! String == Auth.auth().currentUser?.email {


                                    let db = Firestore.firestore()


                                    db.collection("paketler").document(doc.get("packet_id") as! String).addSnapshotListener { snapshott, error in
                                        if error != nil {
                                            print(error)

                                            self.gunlukrev = snapshott?.get("getiri") as! Double + self.gunlukrev
                                            self.gunluk.text = "Günlük +\(self.gunlukrev)$"

                                        }
                                    }

                            }
                            
                            
                            
                            
                            
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            let datee = dateFormatter.date(from: doc.get("date") as! String)
                            
                            let diffComponents = Calendar.current.dateComponents([.minute, .second], from: datee! , to: Date.now)
                            let minutes = diffComponents.minute
                            let seconds = diffComponents.second

                            if minutes! > 1440 {
                                
                                self.getpaketdetay(paketkodu: doc.get("packet_id") as! String, userid: doc.get("sahip") as! String, realid : doc.documentID as! String)
                                
                            }
                            
                        }
                       
                    }
                }
               
            }
        }
        

    }
    
    
    @objc func getpaketdetay(paketkodu : String, userid : String , realid : String) {
        


        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("paketler").document(paketkodu).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if  snapshot != nil{
                    
                    self.updatebakiyemone(paketgetiri: snapshot?.get("getiri") as! String, userid: userid,realid: realid)

                }
        
                
            }
            

        }
        

    }
    var kontrol = 0
    @objc func updatebakiyemone(paketgetiri : String , userid : String , realid : String) {
        
        let db = Firestore.firestore()

        db.collection("users").whereField("eposta", isEqualTo: userid)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        
                        self.updatebakiyemtwo(paketgetiri: paketgetiri, userid: document.documentID , nowbakiye: document.get("bakiye") as! String, realid: realid)
                        
                    }
                }
        }
        
        
        
        
        
        
        
        
    }
    
    @objc func updatebakiyemtwo(paketgetiri : String , userid : String , nowbakiye : String , realid : String) {
        
        var bakiyembe = String()
        
        bakiyembe = "\(Double(nowbakiye)! + Double(paketgetiri)!)"
        
        let firestoredb = Firestore.firestore()
        let newnote = ["bakiye":bakiyembe as! String] as [String : Any]
        firestoredb.collection("users").document(userid).setData(newnote, merge: true)
        
        self.updatebakiyemtre(packetidsi: realid)

        
    }
    
    @objc func updatebakiyemtre(packetidsi : String) {
        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = df.string(from: date)
        
        let firestoredb = Firestore.firestore()
        let newnote = ["date":dateString] as [String : Any]
        firestoredb.collection("paketlerim").document(packetidsi).setData(newnote, merge: true)

        
    }
    
    
    var gunlukrev = Double()
    var yatirimlarim = 0
    @objc func getgünlükgetiri() {
        


        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("paketlerim").whereField("sahip", isEqualTo: Auth.auth().currentUser?.email as! String).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{

                    self.gunlukrev = 0
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            
                            print("sorgu var ")
                            self.yatirimlarim = self.yatirimlarim + Int(doc.get("fiyat") as! String)!
                            
                        }
                        
                        
                        
                    }

                }
                
                
            }
            self.beklemedelbl.text = "Yatırımda (+\(self.yatirimlarim)$)"

            self.gunluk.text = "Günlük +\(self.gunlukrev)$"
            
            

        }
        

    }
    
    
    @objc func eklee() {
        performSegue(withIdentifier: "paket", sender: nil)

    }
    
    @IBOutlet weak var eklemeye: UIView!
    
    
    @IBOutlet weak var beklemedelbl: UILabel!
    var totall = 0
    @objc func getbekleyen() {
        


        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("yatirmatalep").whereField("sahip", isEqualTo: Auth.auth().currentUser?.email as! String).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{

                    self.gunlukrev = 0
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            
                            self.totall = self.totall + (Int(doc.get("tutar") as! String) ?? 0)
                            
                            
                        }
                        
                        
                        
                    }

                }
                
                
            }
            
            
            

        }
        

    }
    
    @IBOutlet weak var gunluk: UILabel!
    
}
