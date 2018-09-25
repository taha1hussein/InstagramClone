
//
//  profileVC.swift
//  InstagramClone
//
//  Created by Ahmed Burham on 7/15/18.
//  Copyright © 2018 Ahmed Burham. All rights reserved.
//

import UIKit
import Firebase
class profileVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    var ProfileData = [profileImages]()
    @IBOutlet weak var profileUserFollower: UILabel!
    @IBOutlet weak var profileUserFollowing: UILabel!
    @IBOutlet weak var profileUserName: UILabel!
    @IBOutlet weak var profileUserImage: UIImageView!
    var ref : DatabaseReference!
    
    @IBOutlet weak var mycollection: UICollectionView!
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
    var myimage:UILabel!
    var following:String!
    var follower:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        let  uid = Auth.auth().currentUser?.uid
        ref = Database.database().reference()
        ref.child("User").observeSingleEvent(of: .value, with: {snap in
            if let data = snap.value as?[String:AnyObject]{
                for(_,item) in data{
                    if uid == item["uid"]as! String{
                        let follower = item["followernumber"] as! Int
                        self.profileUserFollower.text = String(follower)
                        let name = item["Name"] as! String
                        let image = item["imageurl"] as! String
                        self.profileUserName.text = name
                        let myurl = URL(string: image)
                        
                        self.downloadImage(url: myurl!, myImage: self.profileUserImage)
                        if let following = item["followingNumber"]as? [String:AnyObject]{
                            
                                 let followinguser = following["FollowingBumber"]as! Int
                                self.profileUserFollowing.text = ("\(followinguser)")
                                
                            
                            
                        }
                            }
                }
            }
        
        })
        
        ref.child("Posts").observeSingleEvent(of: .value, with: {snap in
            if  let data = snap.value as? [String:AnyObject]{
                for (_,item)in data{
                   // self.ProfileData.removeAll()
                    if let userId = item["uid"]as? String{
                        if uid == userId{
                            let new = profileImages()
                            let imagess = item["postUrl"]as! String
                            new.image = imagess
                            self.ProfileData.append(new)
                            print("dsfsdfsdf")
                        }
                    }
                    
                }
                self.mycollection.reloadData()
            }
            
        })
        //print(ProfileData.count)
    }

    override func viewDidAppear(_ animated: Bool) {
       // let uid = Auth.auth().currentUser?.uid
       // ref = Database.database().reference()
        
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func logout_btn(_ sender: Any) {
        do{
            try  Auth.auth().signOut()
           // dismiss(animated: true, completion: nil)
            let  main = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")
            self.present(main, animated: true, completion: nil)
        }catch{}
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProfileData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)as! CollectionViewCell
        let url = URL(string: ProfileData[indexPath.row].image)
        
        downloadImage(url: url!, myImage: cell.views)
        print(ProfileData.count)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let  main = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = main.instantiateViewController(withIdentifier: "ImagesVC")as! ImagesVC
        vc.curr = ProfileData[indexPath.row]
        present(vc, animated: true, completion: nil)
    }
    
    
}
