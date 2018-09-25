//
//  ActivityVC.swift
//  InstagramClone
//
//  Created by Ahmed Burham on 7/15/18.
//  Copyright © 2018 Ahmed Burham. All rights reserved.
//

import UIKit
import Firebase
class ActivityVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var ActivityData = [NamesLikes]()
    var userss = [String]()
    var ref:DatabaseReference!
    @IBAction func MenuBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController")
        self.present(vc, animated: true, completion: nil)
        
    }
    //@IBOutlet weak var setting: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
         ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        ref.child("Posts").observeSingleEvent(of: .value, with: { (snap) in
            if let data = snap.value as? [String:AnyObject]{
                //      print("new")
                //let newuid = self.ActivityData[indexPath.row].uid
                
                for (_,item) in data {
                    if uid == item["uid"] as? String{
                        if let likeUser = item["LikedUsers"] as? [ String : AnyObject]{
                        self.ActivityData.removeAll()
                            for (Mykey,Userdata) in likeUser{
                        if let uidd = Userdata as? String{
                            //let new = NamesLikes()
                            //new.name = name
                            //print(new.name)
                            print(uidd)
                            if uidd != uid{
                            self.userss.append(uidd)
                            }
                            //self.ActivityData.append(new)
                                }
                            }
                            //cell.ActivityNameUser.text = name
                            
                        }
                    }
                }
                
            }
           // self.Table.reloadData()
        })
        
        
        //// Get users Name
        ref.child("User").observeSingleEvent(of: .value, with: { (snap) in
            if let data = snap.value as? [String:AnyObject]{
                //      print("new")
                //let newuid = self.ActivityData[indexPath.row].uid
                for userData in self.userss{
                        for (_,item) in data {
                              if userData == item["uid"] as? String{
                                   // self.ActivityData.removeAll()
                               // print("hi")
                                          if let name = item["Name"]as? String{
                                    let new = NamesLikes()
                                    new.name = name
                                    print(new.name)
                                    //self.A.append(uid)
                                    
                                    self.ActivityData.append(new)
                            }
                        }
                    }
                }
                
            }
            self.Table.reloadData()
        })
        
        //////////////////////////////////
        //print(ActivityData.count)
            }
    @IBAction func logout(_ sender: Any) {
    
    do{
            try  Auth.auth().signOut()
            //dismiss(animated: true, completion: nil)
            let  main = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")
            self.present(main, animated: true, completion: nil)
        }catch{}

    }
    /*func getUsersLiked(){
        let uid = Auth.auth().currentUser?.uid
        ref.child("Posts").observeSingleEvent(of: .value, with: { (snap) in
            if let data = snap.value as? [String:AnyObject]{
                //      print("new")
                //let newuid = self.ActivityData[indexPath.row].uid
                
                for (_,item) in data {
                    if uid == item["uid"] as? String{
                        let new = NamesLikes()
                        if let name = item["LikesNames"]as? String{
                            new.name = name
                            self.ActivityData.append(new)
                            
                            //cell.ActivityNameUser.text = name
                        }
                    }
                }
                
                self.Table.reloadData()
            }
        })
    }*/
    @IBOutlet weak var Table: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return ActivityData.count
        //return  2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as! cell
        //print("1ss")
        
        //cell.ActivityNameUser.text = Auth.auth().currentUser?.displayName
        cell.ActivityNameUser.text = ActivityData[indexPath.row].name
        //cell.ActivityNameUser.text = "sdf"
        //print(ActivityData.count)
        //getUsersLiked()
        
        return cell
    }
    
}
