//
//  ConProfileViewController.swift
//  Cosplayr
//
//  Created by Tony T. on 7/13/17.
//  Copyright © 2017 Phantom Hex. All rights reserved.
//

import UIKit
import Firebase

class ConProfileViewController: UIViewController {
        @IBOutlet weak var ConventionNameLabel: UILabel!
        @IBOutlet weak var emailNameLabel: UILabel!
        @IBOutlet weak var conventionIDLabel: CustomizableTextfield!
        @IBOutlet weak var countryNameLabel: UILabel!
        @IBOutlet weak var userProfileImageView: CustomizableImageView!
        
        
        var netService = ConServices()
        
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
            
            fetchCurrentConInfo()
        }
        
        
        private func fetchCurrentConInfo(){
            netService.fetchCurrentConvention { (convention) in
                if let user = convention {
                    self.countryNameLabel.text = user.country
                    self.conventionIDLabel.text = "ID#" + user.conventionID!
                    self.ConventionNameLabel.text = user.conventionName
                    self.emailNameLabel.text = user.email
                    self.userProfileImageView.sd_setImage(with: URL(string: user.profilePictureUrl!), placeholderImage: UIImage(named: "default"))
                }
            }
        }
}
