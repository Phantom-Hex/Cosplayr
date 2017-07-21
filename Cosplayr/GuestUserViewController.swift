//
//  GuestUserViewController.swift
//  Cosplayr
//
//  Created by Tony T. on 7/19/17.
//  Copyright © 2017 Phantom Hex. All rights reserved.
//

import UIKit
import Firebase

class GuestUserViewController: UIViewController {
    
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var guestImageView: UIImageView!
    
    
    var ref: DatabaseReference?
    var netService = NetService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setGuestUserInfo()
    }
    
    private func setGuestUserInfo() {
        if let ref = ref {
            netService.fetchGuestUser(ref: ref, completion: { (user) in
                if let user = user {
                    self.countryLabel.text = user.country
                    self.emailLabel.text = user.email
                    self.firstnameLabel.text = user.firstname
                    self.lastnameLabel.text = user.lastname
                    self.guestImageView.sd_setImage(with: URL(string: user.profilePictureUrl), placeholderImage: UIImage(named: "default"))
                }
            })
        }
    }
}
