//
//  showmenu.swift
//  InstagramClone
//
//  Created by Ahmed Burham on 8/1/18.
//  Copyright © 2018 Ahmed Burham. All rights reserved.
//

import UIKit

class showmenu: UIViewController {

    @IBOutlet weak var settings: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if revealViewController() != nil {
            
            settings.target = revealViewController()
            settings.action = "revealToggle:"
            
        }

    }
    @IBAction func BackBtn(_ sender: Any) {
        /*let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "showmenu")
        self.present(vc, animated: true, completion: nil)
        */
        self.dismiss(animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
