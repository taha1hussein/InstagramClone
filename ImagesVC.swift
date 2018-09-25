//
//  ImagesVC.swift
//  InstagramClone
//
//  Created by Ahmed Burham on 7/21/18.
//  Copyright © 2018 Ahmed Burham. All rights reserved.
//

import UIKit

class ImagesVC: UIViewController {
    var curr:profileImages!
    @IBOutlet weak var downloadedImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string: curr.image)!
        downloadImage(url: myURL, myImage: downloadedImage)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Savebtn(_ sender: Any) {
        
        let data = UIImagePNGRepresentation(downloadedImage.image!)
        let compresed = UIImage(data:data!)
        UIImageWriteToSavedPhotosAlbum(compresed!, nil, nil, nil)
        let alet = UIAlertController(title:"saved",message:"your photo saved",preferredStyle:.alert)
        let action = UIAlertAction(title:"ok",style:.default,handler:nil)
        alet.addAction(action)
        self.present(alet, animated: true, completion: nil)
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
    
}
