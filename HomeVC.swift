//
//  HomeVC.swift
//  InstagramClone
//
//  Created by Ahmed Burham on 7/15/18.
//  Copyright © 2018 Ahmed Burham. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
var  check :Bool = false
class HomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var usersLikes = [String]()
    
    @IBOutlet weak var HomeTable: UITableView!
   var ImagesData = [UserImages]()
    var HomeData = [PostData]()
    var userUID = [String]()
    var ref:DatabaseReference!
    var database:DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        let uid = Auth.auth().currentUser?.uid
        ref = Database.database().reference()
        database = Database.database().reference()
          ref.child("User").observeSingleEvent(of: .value, with: {snap in
            if let data = snap.value as? [String:AnyObject]{
                for (_,each) in data{
                     //self.userUID.removeAll()
                    if each["uid"]as? String == uid{
                       
                        if let following = each["Following"]as? [String:AnyObject]{
                            
                            for(_,new)in  following{
                                
                            self.userUID.append(new as! String)
                                
                            }
                        }
                    
        self.userUID.append(uid!)
                       // print(uid!)
                        //self.ref.removeAllObservers()
                        /*self.ref.child("User").observeSingleEvent(of: .value, with: {snapshot in
                            if  let newdata = snapshot.value as?[String:AnyObject]{
                                 for (new)in self.userUID{
                                    for (_,data) in newdata{
                                   // self.ImagesData.removeAll()
                                   
                                        if data["uid"]as? String == new{
                                    var Data =  UserImages()
                                    Data.photos = data["imageurl"] as! String
                                        self.ImagesData.append(Data)
                                     print(data["imageurl"])
                                        }
                                    }
                                }
                                //self.HomeTable.reloadData()
                            }
                        })*/
                       //self.ref.removeAllObservers()
        self.ref.child("Posts").observeSingleEvent(of: .value, with: {snap in
            if let data = snap.value as? [String:AnyObject]{
                for (_,item) in data{
                    //self.HomeData.removeAll()
                    if  let  Newuid = item["uid"]as? String{
                        for key  in self.userUID{
                            if  key == Newuid{
                            var Item = PostData()
                                Item.Author = item["Author"]as! String
                                Item.postId = item["PostID"]as! String
                                Item.postImage = item["postUrl"]as! String
                                Item.uid = item["uid"]as! String
                                Item.like = item["Like"]as! Int
                                Item.unlike = item["UnLike"]as! Int
                                self.HomeData.append(Item)
                            }
                        
                        }
                        
                    }
                
                }
                self.HomeTable.reloadData()
                
            }
            
        })
                        self.ref.child("User").observeSingleEvent(of: .value, with: {snapshot in
                            if  let newdata = snapshot.value as?[String:AnyObject]{
                                for (new)in self.HomeData{
                                    for (_,data) in newdata{
                                        // self.ImagesData.removeAll()
                                        
                                        if data["uid"]as? String == new.uid{
                                            var Data =  UserImages()
                                            Data.photos = data["imageurl"] as! String
                                            self.ImagesData.append(Data)
                                                print(data["imageurl"])
                                        }
                                    }
                                }
                                self.HomeTable.reloadData()
                            }
                        })
                        
                    }
                }
                
            }
            
          })
        ref.removeAllObservers()
        
    }
    
    

    @IBAction func unlikeBtn(_ sender: Any) {
        let  uid = Auth.auth().currentUser?.uid
        let number = (sender as AnyObject).tag
        let postID = HomeData[number!].postId
        let userid = HomeData[number!].uid
       // let userKey = ref.child("Posts").queryOrderedByKey()
       // print(userKey)
        ref.child("Posts").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snap) in
            if let data = snap.value as? [String:AnyObject]{
                //      print("new")
               // print("ni")
                //let newuid = self.ActivityData[indexPath.row].uid
                for (_,item) in data{
                 let likeUser = item["LikedUsers"] as? [ String : AnyObject]
                            print("ni")
                            for (Mykey,Userdata) in likeUser!{
                                if  uid == Userdata as? String{
                                    print("dfdsfsdf")
                                    self.ref.child("Posts").child("LikedUsers/\(Mykey)").removeValue()
                        }
                            
                    }
                }
                
            }
            // self.Table.reloadData()
        })
        
        
        
        database.child("Posts").queryOrderedByKey().observeSingleEvent(of: .value, with: {snap in
            if let data = snap.value as?[String:AnyObject]{
                for (_,item) in data{
                    //print("1")
                    if let post = item["PostID"]as? String{
                        //print("2")
                        if post  == postID{
                            //print("3")
                            var NewData = item["UnLike"]as! Int
                            //var myvalue = Data
                            NewData = NewData + 1
                            
                            var posts = ["UnLike":NewData]
                            self.database.child("Posts").child(postID!).updateChildValues(posts)
                            print("unlike\(NewData)")
                            
                        }
                    }
                }
            }
    
        })
    }
    var likeNumber = 0
    @IBAction func likeBtn(_ sender: Any) {
        check = true
        let key = database.child("Posts").childByAutoId().key
        let  uid = Auth.auth().currentUser?.uid
        let number = (sender as AnyObject).tag
        let postID = HomeData[number!].postId
        let userid = HomeData[number!].uid
        let Noti:[String:AnyObject] = ["\(key)":uid as AnyObject]
        //print(uid)
        usersLikes.append(uid!)
        database.child("Posts").queryOrderedByKey().observeSingleEvent(of: .value, with: {snap in
            if let data = snap.value as?[String:AnyObject]{
                for (_,item) in data{
                //print("1")
                if let post = item["PostID"]as? String{
                   // print("2")
                if post  == postID{
                    //print("3")
                var Data = item["Like"]as! Int
                    
                //var myvalue = Data
                Data = Data + 1
                   // self.NewData = self.NewData - 1
                var posts = ["Like":Data]
                   // var likesUsers = ["\(kety)":uid]
                self.database.child("Posts").child(postID!).updateChildValues(posts)
                   self.database.child("Posts").child(postID!).child("LikedUsers").updateChildValues(Noti)
                    
                         }
                    }
                }
        }
    })
       /* let content = UNMutableNotificationContent()
        content.title = "notification"
        content.body = "This  is body"
        var triger = UNTimeIntervalNotificationTrigger(timeInterval:2,repeats:false)
        
      let request = UNNotificationRequest(identifier:"Any",content:content,trigger:triger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    */
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

            //present("LoginVC", animated: true, completion: nil)
        }catch{}
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ImagesData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        //cell.HomeUserImage.layer.cornerRadius = cell.HomeUserImage.frame.size.width/2
       // cell.HomeUserImage.layer.cornerRadius = cell.HomeUserImage.frame.size.height/2
        cell.HomeUserName.text = HomeData[indexPath.row].Author
        //cell.HomeUserImage.clipsToBounds = true
        let myurl = URL(string: HomeData[indexPath.row].postImage)
        
        downloadImage(url: myurl!, myImage: cell.HomeImage)
        
        let url = URL(string: ImagesData[indexPath.row].photos)
        
        downloadImage(url: url!, myImage: cell.HomeUserImage)
        cell.unlike.tag = indexPath.row
        cell.Like.tag = indexPath.row
        
        
        cell.LikeLabel.text = "\(HomeData[indexPath.row].like)"
        cell.unlikesLabel.text = "\(HomeData[indexPath.row].unlike)"
        //print(Int(HomeData[indexPath.row].postId)!)
        //print(HomeData[indexPath.row].postId)
        return cell
    }
    
}
