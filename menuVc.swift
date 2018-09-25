//
//  menuVc.swift
//  InstagramClone
//
//  Created by Ahmed Burham on 7/31/18.
//  Copyright © 2018 Ahmed Burham. All rights reserved.
//

import UIKit
import Firebase
class menuVc: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    //let curr = imageMenu()
    //var  myHome = [imageMenu]()
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var TableView: UITableView!
    var ManuNameArray:Array = [String]()
    var iconArray:Array = [UIImage]()
    var ref : DatabaseReference!
    /*override func  viewDidAppear(_ animated: Bool) {
        let uid = Auth.auth().currentUser?.uid
        ref = Database.database().reference()
        ref.child("User").observeSingleEvent(of: .value, with: {snap in
            if let data = snap.value as? [String:AnyObject]{
                for (_,key) in data{
                    if key["uid"]as! String == uid{
                    var item = imageMenu()
                        if let image = key["imageurl"]as? String{
                        
                        item.image = image
                            print(image)
                        }
                        
                        //self.myHome.append(item)
                    
                    }
                }
            }
        
        })
   }
   */
    override func viewDidLoad() {
        super.viewDidLoad()
        ManuNameArray = ["Home","Message","Map","Setting"]
        iconArray = [UIImage(named:"home")!,UIImage(named:"message")!,UIImage(named:"map")!,UIImage(named:"setting")!]
        
        userImage.layer.borderWidth = 2
        userImage.layer.borderColor = UIColor.green.cgColor
        userImage.layer.cornerRadius = 50
        
        userImage.layer.masksToBounds = false
        userImage.clipsToBounds = true
       //let myURL = URL(string: curr.image)!
       // downloadImage(url: myURL, myImage: userImage)
        
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL, myImage:UIImageView) {
        //print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            //print("Download Finished")
            DispatchQueue.main.async() {
                myImage.image = UIImage(data: data)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ManuNameArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        cell.Label.text! = ManuNameArray[indexPath.row]
        cell.Images.image = iconArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let revealviewcontroller:SWRevealViewController = self.revealViewController()
        
        let cell:TableViewCell = tableView.cellForRow(at: indexPath) as! TableViewCell
        print(cell.Label.text!)
        if cell.Label.text! == "Home"
        {
            print("Home Tapped")
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
            
            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
            
            
        }
        if cell.Label.text! == "Message"
        {
            print("message Tapped")
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "photoVC") as! photoVC
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
            
            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
            
        }
        if cell.Label.text! == "Map"
        {
            print("Map Tapped")
            
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "mapVc") as! mapVc
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
            
            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
        }
        if cell.Label.text! == "Setting"
        {
            print("setting Tapped")
            
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "profileVC") as! profileVC
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
            
            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
           
            
        }
    }
    
    

    

}
