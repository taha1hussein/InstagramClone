//
//  LoginVC.swift
//  InstagramClone
//
//  Created by Ahmed Burham on 7/15/18.
//  Copyright © 2018 Ahmed Burham. All rights reserved.
//

import UIKit
import Firebase
class LoginVC: UIViewController {

    @IBOutlet weak var email: UITextField!
   
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil{
        self.presentHome()
        }
    }
    @IBAction func login(_ sender: Any) {
        /*if email.text! == "" || password.text! == ""{
            let alert = UIAlertController(title:"Confirmation",message:"Make sure that all fields are completed",preferredStyle:.alert)
            
        alert.addAction(UIAlertAction(title:"ok",style:.default,handler:nil))
            dismiss(animated: true, completion: nil)
        }*/
    Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
        if let err = error{
        print(err.localizedDescription)
        }
        else{
       self.presentHome()
        }
        }
    
    }
    func presentHome(){
    
        let  main = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarVC")
        self.present(main, animated: true, completion: nil)
    }
    
    }
