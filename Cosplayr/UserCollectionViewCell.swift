//
//  UserCollectionViewCell.swift
//  Cosplayr
//
//  Created by Tony T. on 7/12/17.
//  Copyright © 2017 Phantom Hex. All rights reserved.
//

import UIKit
import Firebase

class UserCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var verifiedUserImageView: UIImageView!
    
    
    func configureCellForUser(user: User){
        self.countryLabel.text = user.country
        self.username.text = user.getFullname()
        downloadImageFromFirebase(urlString: user.profilePictureUrl!)
        self.verifiedUserImageView.isHidden = !user.isVerified
        
    }
    
    
    func downloadImageFromFirebase(urlString: String){
        
        let storageRef = Storage.storage().reference(forURL: urlString)
        storageRef.getData(maxSize: 1 * 1024 * 1024) { (imageData, error) in
            if error != nil {
                print(error!.localizedDescription)
            }else {
                if let data = imageData {
                    DispatchQueue.main.async(execute: {
                        self.userImageView.image = UIImage(data: data)
                    })
                    
                }
            }
        }
    }
}
