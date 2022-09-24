//
//  paketler.swift
//  strong_sunny
//
//  Created by Can Kirac on 8.06.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import SDWebImage

class paketler: UIViewController, UITableViewDelegate , UITableViewDataSource {
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tablee.delegate = self
        tablee.dataSource = self
        
        getpaket()
        
        tomain.isUserInteractionEnabled = true
        let tom = UITapGestureRecognizer(target: self, action: #selector(tom))
        tomain.addGestureRecognizer(tom)

        // Do any additional setup after loading the view.
    }
    
    @objc func tom() {
        performSegue(withIdentifier: "tom", sender: nil)
    }
    
    @IBOutlet weak var tomain: UIImageView!
    
    @IBOutlet weak var tablee: UITableView!
    
    
    var paketname = [String]()
    var paketfiyat = [String]()
    var paketimg = [String]()
    var paketoran = [String]()
    var paketgetiri = [String]()
    var havuz = [String]()
    var idsi = [String]()
    
    @objc func getpaket() {
        


        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("paketler").order(by: "fiyat").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{

                    self.paketimg.removeAll()
                    self.paketname.removeAll()
                    self.paketfiyat.removeAll()
                    self.paketoran.removeAll()
                    self.paketgetiri.removeAll()
                    self.havuz.removeAll()
                    self.idsi.removeAll()
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            
                            
                            self.paketimg.append(doc.get("img") as! String)
                            self.paketoran.append(doc.get("oran") as! String)
                            self.paketname.append(doc.get("name") as! String)
                            self.paketfiyat.append(doc.get("fiyat") as! String)
                            self.paketgetiri.append(doc.get("getiri") as! String)
                            self.havuz.append(doc.get("havuz") as! String)
                            self.idsi.append(doc.documentID as! String)
                           
                            
                        }
                        
                        
                        
                    }

                }
                
                
            }
            self.tablee.reloadData()
            
            

        }
        

    }
    
    var chosenpanel = ""
    var chosenoran = ""
    var chosenimg = ""
    var chosenfiyat = ""
    var chosenids = ""
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        chosenoran = "\(paketoran[indexPath.row]) (\(paketgetiri[indexPath.row])$)"
        chosenfiyat = "\(paketfiyat[indexPath.row])"
        chosenimg = paketimg[indexPath.row]
        chosenids = idsi[indexPath.row]
        chosenpanel = paketname[indexPath.row]
        performSegue(withIdentifier: "start", sender: nil)

    }
    
    var chosenpackrekor = "0"
    var chosensahib = ""
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "start" {
            let destiantionVC = segue.destination as! odeme_page
            destiantionVC.fiyatl = chosenfiyat
            destiantionVC.panelnamel = chosenpanel
            destiantionVC.paneloranl = chosenoran
            destiantionVC.panelucretl = chosenfiyat
            destiantionVC.panelimgl = chosenimg
            destiantionVC.packetid = chosenids
            destiantionVC.fiyatdouble = Double(chosenfiyat)!
            
            
    }
        
    
}
    
   

}
