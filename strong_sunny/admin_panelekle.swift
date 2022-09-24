//
//  admin_panelekle.swift
//  strong_sunny
//
//  Created by Can Kirac on 11.06.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class admin_panelekle: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == userpick {
            return users.count

                } else if pickerView == packetpick{
                   //pickerView2
                    return packetname.count
        }
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == userpick {
            return users[row]

                } else if pickerView == packetpick{
                   //pickerView2
                    return packetname[row]
        }
        return "1"
    }
    @IBOutlet weak var packetpick: UIPickerView!
    
    @IBOutlet weak var userpick: UIPickerView!
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == userpick {
            self.selecteduser = users[row]
            
                } else if pickerView == packetpick{
                   //pickerView2
                    self.selectedpaket = paketid[row]
                    self.selectedprice = paketfiyat[row]
        }
        
    }

    var selectedprice = ""
    var selectedpaket = "36AHTtDUFRk9Rpsxr934"
    var selecteduser = ""
    
    var packetname = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getusers()
        getpacket()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var kullanici: UIPickerView!
    
    @IBOutlet weak var paket: UIPickerView!
    
    var users = [String]()
    
    @objc func getusers() {
        


        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("users").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{

                    self.users.removeAll()
                    
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            
                            
                            self.users.append(doc.get("eposta") as! String)
                            
                           
                            
                        }
                        
                        
                        
                    }

                }
                
                
            }
            self.selecteduser = self.users[0]
            self.userpick.dataSource = self
            self.userpick.delegate = self
            self.userpick.reloadAllComponents()
            
        }
        

    }
    
    var pakehavuz = [String]()
    var paketoran = [String]()
    var paketgetiri = [String]()
    var paketid = [String]()
    var paketfiyat = [String]()
    @objc func getpacket() {
        


        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("paketler").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{

                    self.packetname.removeAll()
                    self.paketoran.removeAll()
                    self.pakehavuz.removeAll()
                    self.paketgetiri.removeAll()
                    self.paketid.removeAll()
                    self.paketfiyat.removeAll()
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            
                            
                            self.packetname.append(doc.get("name") as! String)
                            self.pakehavuz.append(doc.get("havuz") as! String)
                            self.paketoran.append(doc.get("oran") as! String)
                            self.paketgetiri.append(doc.get("getiri") as! String)
                            self.paketid.append(doc.documentID as! String) 
                            self.paketfiyat.append(doc.get("fiyat") as! String)
                            
                        }
                        
                        
                        
                    }

                }
                
                
            }
            self.selectedpaket = self.paketid[0]
            self.paket.dataSource = self
            self.paket.delegate = self
            self.paket.reloadAllComponents()
            
        }
        

    }
    var getdatam = ""
    
    @IBAction func ekle(_ sender: Any) {
        
        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = df.string(from: date)
        

                            
                            let firestore = Firestore.firestore()
        let firestorepacket = ["date":dateString,"packet_id":self.selectedpaket,"sahip":self.selecteduser,"durum":"1","fiyat":self.selectedprice] as [String : Any]
                            
                            var firestoreref : DocumentReference?
                            firestoreref = firestore.collection("paketlerim").addDocument(data: firestorepacket, completion: { error in
                                if error != nil {
                                    print("hata aldın")
                                }
                                else {
                                    self.showAlertButtonTapped()

                                }
                            })
        
        
    }
  
            
        
    @objc func showAlertButtonTapped() {

           

        let alert = UIAlertController(title: "Başarılı", message: "Kullanıcıya paket tanımlandı.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { action in
            switch action.style{
                case .default:
                
                self.performSegue(withIdentifier: "geri", sender: nil)
                
            case .cancel:
                self.performSegue(withIdentifier: "geri", sender: nil)


            case .destructive:
                self.performSegue(withIdentifier: "geri", sender: nil)


            @unknown default:
                self.performSegue(withIdentifier: "geri", sender: nil)


            }
        }))
        self.present(alert, animated: true, completion: nil)
        }
            
        
    
    

}
