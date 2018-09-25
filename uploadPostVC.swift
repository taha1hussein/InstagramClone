//
//  uploadPostVC.swift
//  InstagramClone
//
//  Created by Ahmed Burham on 7/16/18.
//  Copyright © 2018 Ahmed Burham. All rights reserved.
//

import UIKit
import Firebase
class uploadPostVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate  {
    var ref:DatabaseReference!
    var storage:StorageReference!
    @IBOutlet weak var postsImages: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        postsImages.layer.cornerRadius = postsImages.frame.size.width/2
         postsImages.layer.cornerRadius = postsImages.frame.size.height/2
         postsImages.clipsToBounds = true
        ref = Database.database().reference()
        storage = Storage.storage().reference(forURL: "gs://instagramclone-ba42c.appspot.com").child("photos")
    }
    @IBAction func uploadPosts(_ sender: Any) {
        let uid = Auth.auth().currentUser?.uid
        let postid = ref.child("User").childByAutoId().key
        
        let  imageRef = storage.child("\(uid).jpg")
        let image = UIImageJPEGRepresentation(self.postsImages.image!, 0.6)
        let  upload = imageRef.putData(image!, metadata: nil) { (metdata, error) in
            if let err = error{
            print(error?.localizedDescription)
                return
            }
            imageRef.downloadURL(completion: { (url, error) in
                let Data :[String:AnyObject] = ["postUrl":url?.absoluteString as AnyObject,
                                                "PostID":postid as AnyObject,
                                                "Author":Auth.auth().currentUser?.displayName as AnyObject,
                                                "uid":uid as AnyObject,
                                                "Like":0 as AnyObject,
                                                "UnLike":0 as AnyObject,
                                                
                                               
                                                ]
               // let mykey = ["\(uid)":Data]
                self.ref.child("Posts").child(postid).updateChildValues(Data)
                //let  notification = ["Notification"]
               // self.ref.child("Posts").child(postid).updateChildValues(notification)
              //  let me = ["Notification":]
                let  main = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarVC")
                self.present(main, animated: true, completion: nil)

            })
        }
        upload.resume()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let  controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if  let  selectedimage = info[UIImagePickerControllerOriginalImage]as? UIImage{
            postsImages.image = selectedimage
            
            
            dismiss(animated: true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
