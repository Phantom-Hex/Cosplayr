//
//  Convention.swift
//  Cosplayr
//
//  Created by Tony T. on 7/13/17.
//  Copyright © 2017 Phantom Hex. All rights reserved.
//

import Foundation
import Firebase

struct Convention {
    
    var email: String!
    var firstname: String?
    var lastname: String?
    var conventionName: String!
    var conventionID: String?
    var uid: String!
    var profilePictureUrl: String?
    var country: String?
    var ref: DatabaseReference!
    var key: String! = ""
    var isVerified: Bool! = true
    
    
    
    init(snapshot: DataSnapshot){
        
        self.email = (snapshot.value as! NSDictionary)["email"] as! String
        self.firstname = (snapshot.value as! NSDictionary)["firstname"] as? String
        self.lastname = (snapshot.value as! NSDictionary)["lastname"] as? String
        self.conventionName = (snapshot.value as! NSDictionary)["conventionName"] as? String
        self.conventionID = (snapshot.value as! NSDictionary)["conventionID"] as? String
        self.uid = (snapshot.value as! NSDictionary)["uid"] as! String
        self.country = (snapshot.value as! NSDictionary)["country"] as? String
        self.profilePictureUrl = (snapshot.value as! NSDictionary)["profilePictureUrl"] as? String
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.isVerified = (snapshot.value as! NSDictionary)["isVerified"] as! Bool
    }
    
    
    init(email: String, firstname: String, lastname: String, uid: String, profilePictureUrl: String, country: String, conventionName: String, conventionID: String){
        
        self.email = email
        self.firstname = firstname
        self.lastname = lastname
        self.conventionName = conventionName
        self.conventionID = conventionID
        self.uid = uid
        self.profilePictureUrl = profilePictureUrl
        self.country = country
        self.ref = Database.database().reference()
    }
    
    func getFullname() -> String{
        
        return "\(String(describing: firstname)) \(String(describing: lastname))"
    }
    
    func toAnyObject() -> [String : Any]{
        return ["email":self.email,"firstname":self.firstname!,"lastname":self.lastname!,"conventionID":self.conventionID!, "conventionName":self.conventionName, "country":self.country!,"uid":self.uid,"profilePictureUrl":profilePictureUrl!,"isVerified":self.isVerified]
    }
}
