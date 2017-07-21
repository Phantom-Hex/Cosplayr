//
//  UserProfileViewController.swift
//  Cosplayr
//
//  Created by Tony T. on 7/19/17.
//  Copyright © 2017 Phantom Hex. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var lastnameTextfield: UILabel!
    @IBOutlet weak var firstnameTextField: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    
    var netService = NetService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        fetchCurrentUserInfo()
    }
    
    
    private func fetchCurrentUserInfo(){
        netService.fetchCurrentUser { (user) in
            if let user = user {
                self.countryLabel.text = user.country
                self.emailLabel.text = user.email
                self.firstnameTextField.text = user.firstname
                self.lastnameTextfield.text = user.lastname
                self.userProfileImageView.sd_setImage(with: URL(string: user.profilePictureUrl), placeholderImage: UIImage(named: "default"))
            }
        }
    }
}
