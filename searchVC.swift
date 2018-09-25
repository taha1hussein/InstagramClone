//
//  searchVC.swift
//  InstagramClone
//
//  Created by Ahmed Burham on 7/15/18.
//  Copyright © 2018 Ahmed Burham. All rights reserved.
//

import UIKit
import Firebase
class searchVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var user = [Users]()
    @IBOutlet weak var myTableView: UITableView!
    
    var database:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        database = Database.database().reference()
    }
    override func viewDidAppear(_ animated: Bool) {
        let uid = Auth.auth().currentUser?.uid
        let data = database.child("User").observeSingleEvent(of: .value, with: {snap in
            let value = snap.value as? [String:AnyObject]
            self.user.removeAll()
            for (_,item) in value!{
                if uid != item["uid"] as! String{
                var downloadedData  = Users()
                    
                    downloadedData.name = item ["Name"]as!String
                    downloadedData.uid = item ["uid"]as!String
                    downloadedData.images = item ["imageurl"]as!String
                   self.user.append(downloadedData)
                    
                }
            }
        self.myTableView.reloadData()
        })
        database.removeAllObservers()
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

    @IBAction func logout_btn(_ sender: Any) {
        do{
            try  Auth.auth().signOut()
            //dismiss(animated: true, completion: nil)
            let  main = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")
            self.present(main, animated: true, completion: nil)
        }catch{}
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCells", for: indexPath)as! UserCells
        cell.nameUser.text = user[indexPath.row].name
        let myurl = URL(string: user[indexPath.row].images)
        
        downloadImage(url: myurl!, myImage: cell.photoUser)
        cell.photoUser.layer.cornerRadius = cell.photoUser.frame.size.width/2
        cell.photoUser.clipsToBounds = true
        let uid = Auth.auth().currentUser?.uid
         database.child("User").child(uid!).child("Following").observeSingleEvent(of: .value, with: {snap in
            if let mydata = snap.value as? [String:AnyObject]{
                for (key,item) in mydata{
                    if  item as! String == self.user[indexPath.row].uid{
                    tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                    
                    }
                }
            
            }
        
        })
        
        return cell
    }
    /////Following and  un Following
    
    var followerno = 0
    var followingno = 0
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let uid = Auth.auth().currentUser?.uid
        if  let cell = tableView.cellForRow(at: indexPath){
            if cell.accessoryType == .none{
    followingno += 1
                followerno = 1
        let  key = database.child("User").childByAutoId().key
        let following = ["\(key)":user[indexPath.row].uid]
        database.child("User").child(uid!).child("Following").updateChildValues(following)
        let follower = ["\(key)":uid]
                let followingNumber = ["FollowingBumber":followingno]
         database.child("User").child(uid!).child("followingNumber").updateChildValues(followingNumber)
                
                database.child("User").child(user[indexPath.row].uid!).child("follower").updateChildValues(follower)
                //var  followernumber = ["FollowerNumber":followerno]
                //database.child("User").child(user[indexPath.row].uid).child("followernumber").updateChildValues(followernumber)
                database.child("User").child(user[indexPath.row].uid).observeSingleEvent(of: .value, with: {snap in
                    if let data = snap.value as?[String:AnyObject]{
                    
                         let userFollower = data["followernumber"]
                        
                                 var myvalue = Int(userFollower as! NSNumber)
                        var  followernumber = ["followernumber":myvalue]
                        myvalue += 1
                                followernumber = ["followernumber":myvalue]
                                self.database.child("User").child(self.user[indexPath.row].uid).updateChildValues(followernumber)
                            
                        
                    }
                
                
                })
        cell.accessoryType = .checkmark
           
            }
        
        else{
       database.child("User").child(uid!).child("Following").observeSingleEvent(of: .value, with: {snapshot  in
            //self.check = true
                if  let  data = snapshot.value as? [String:AnyObject]{
                    for (key,userId) in data{
                        if userId as! String == self.user[indexPath.row].uid{
                    
                            self.database.child("User").child(uid!).child("Following/\(key)").removeValue()
                        self.database.child("User").child(self.user[indexPath.row].uid).child("follower/\(key)").removeValue()
                        }
                    }
                }
            
            })
         
        cell.accessoryType = .none
                
                
                database.child("User").child(uid!).child("followingNumber").observeSingleEvent(of: .value, with: {snap in
                    if let data = snap.value as?[String:AnyObject]{
                        
                        let userFollower = data["FollowingBumber"]
                        
                        var myvalue = Int(userFollower as! NSNumber)
                        var  followingnumber = ["FollowingBumber":myvalue]
                        myvalue -= 1
                        if myvalue > 0{
                        followingnumber = ["FollowingBumber":myvalue]
                        self.database.child("User").child(uid!).child("followingNumber").updateChildValues(followingnumber)
                        
                        }
                        else{
                         self.database.child("User").child(uid!).child("followingNumber").removeValue()
                            self.followingno = 0
                        }
                    }
                })
                
                database.child("User").child(user[indexPath.row].uid).observeSingleEvent(of: .value, with: {snap in
                    if let data = snap.value as?[String:AnyObject]{
                        
                        let userFollower = data["followernumber"]
                        
                        var myvalue = Int(userFollower as! NSNumber)
                        var  followernumber = ["followernumber":myvalue]
                        myvalue -= 1
                        if myvalue > 0{
                        followernumber = ["followernumber":myvalue]
                        
                        
                        }else{
                        followernumber = ["followernumber":0]
                        }
                        self.database.child("User").child(self.user[indexPath.row].uid).updateChildValues(followernumber)
                        
                    }
                    
                    
                })
                
                
            }
        }
    tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
        user.remove(at: indexPath.row)
            myTableView.reloadData()
        }
    }
    
}
