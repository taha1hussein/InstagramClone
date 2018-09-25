//
//  SignupVc.swift
//  InstagramClone
//
//  Created by Ahmed Burham on 7/15/18.
//  Copyright © 2018 Ahmed Burham. All rights reserved.
//

import UIKit
import  Firebase
class SignupVc: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userRepeatPassword: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    var ref:DatabaseReference!
    var storage:StorageReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        storage = Storage.storage().reference(forURL: "gs://instagramclone-ba42c.appspot.com").child("photos")
    }
    override  func  viewDidAppear(_ animated: Bool) {
        userImage.layer.cornerRadius = userImage.frame.size.width/2
        userImage.layer.cornerRadius = userImage.frame.size.height/2
        userImage.clipsToBounds = true
    }
    
    
    
    @IBAction func Signup(_ sender: Any) {
        let  uid = Auth.auth().currentUser?.uid
        
      Auth.auth().createUser(withEmail: userEmail.text!, password: userPassword.text!) { (user, error) in
        if let err = error{
        print(err.localizedDescription)
            return
        }
        if  let user = user{
            let profilename = Auth.auth().currentUser?.createProfileChangeRequest()
            profilename?.displayName = self.userName.text
            profilename?.commitChanges(completion: nil)
            let  imageRef = self.storage.child("\(user.uid).jpg")
            let  image  = UIImageJPEGRepresentation(self.userImage.image!, 0.6)
            let upload = imageRef.putData(image!, metadata: nil, completion: { (metdata, error) in
                if  let err = error{
                print(err.localizedDescription)
                    return
                
                }
                imageRef.downloadURL(completion: { (url, error) in
                    if let  url = url{
                        let Data : [String:AnyObject] = ["Name":self.userName.text as AnyObject,
                                                         "uid":user.uid as AnyObject,
                                                         "imageurl":url.absoluteString as AnyObject,
                            
                                                        "followernumber":0 as AnyObject,
                                                        
                                                         ]
                        self.ref.child("User").child(user.uid).setValue(Data)
                        let  main = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarVC")
                        self.present(main, animated: true, completion: nil)
                    
                    }
                })
            })
            upload.resume()
            
        }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let  controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if  let  selectedimage = info[UIImagePickerControllerOriginalImage]as? UIImage{
            userImage.image = selectedimage
            
            
            dismiss(animated: true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
