//
//  photoVC.swift
//  InstagramClone
//
//  Created by Ahmed Burham on 7/15/18.
//  Copyright © 2018 Ahmed Burham. All rights reserved.
//

import UIKit
import Firebase
class photoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logout_btn(_ sender: Any) {
    
        do{
            try  Auth.auth().signOut()
            //dismiss(animated: true, completion: nil)
            let  main = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")
            self.present(main, animated: true, completion: nil)
        }catch{}
    
    }
}
