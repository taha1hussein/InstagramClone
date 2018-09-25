//
//  chatVC.swift
//  InstagramClone
//
//  Created by Ahmed Burham on 7/22/18.
//  Copyright © 2018 Ahmed Burham. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController
import AVKit
import MobileCoreServices
import Firebase
var  mess = [JSQMessage]()
var ref:DatabaseReference!
class chatVC: JSQMessagesViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        senderId = "1"
        senderDisplayName = "taha"
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let Bubble = JSQMessagesBubbleImageFactory()
        let  mes = mess[indexPath.item]
        return Bubble?.outgoingMessagesBubbleImage(with: UIColor.blue)
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(named:"placeholderImg"), diameter: 30)
    }
    
    //// collection view methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mess.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell  = super.collectionView(collectionView, cellForItemAt: indexPath)as!JSQMessagesCollectionViewCell
        return cell
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return mess[indexPath.item]
    }
    ///// end collection view methods
    
    
    ///send button
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        mess.append(JSQMessage(senderId:senderId,displayName:senderDisplayName,text:text))
        collectionView.reloadData()
        finishSendingMessage()
    }
    
    
}
