//
//  mainam.swift
//  strong_sunny
//
//  Created by Can Kirac on 12.06.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import SDWebImage

class mainam: UIViewController , UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imgurlsler.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablee.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! main_cell
        
        
        cell.imageim.sd_setImage(with: URL(string: self.imgurlsler[indexPath.row] ))
        
        
        
        
        return cell
    }
    
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        tablee.delegate = self
        tablee.dataSource = self
        getimage()
        
       
       
        // Do any additional setup after loading the view.
    }
    var imgyeri = 0
   
   
    
    @IBOutlet weak var baner: UIImageView!
    
    
    
    
    
    
    @objc func getimage() {
        


        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("anasayfaimg").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{

                 
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            
                            self.imgurlsler.append( doc.get("url") as! String)
                           
                            
                        }
                        
                        
                        
                    }

                }
                
               

            }
            self.tablee.reloadData()
            
            
            

        }
        

    }
    
    var imgurlsler = [String]()
    
    @IBOutlet weak var banner: UIImageView!
    
    @IBOutlet weak var tablee: UITableView!
    
    
    var imgurl = ""
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        imgurl = imgurlsler[indexPath.row]
        performSegue(withIdentifier: "büyüt", sender: nil)

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "büyüt" {
            let dest = segue.destination as! buyukresim
            dest.urlll = imgurl
        }
        
    }
     
    
    
    
    

}
