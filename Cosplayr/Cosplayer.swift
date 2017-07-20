//
//  Cosplayer.swift
//  Cosplayr
//
//  Created by Tony T. on 7/13/17.
//  Copyright © 2017 Phantom Hex. All rights reserved.
//

import Foundation
import Firebase

struct Cosplayer {
    
    var email: String!
    var firstname: String?
    var lastname: String?
    var cosplayerID: String?
    var uid: String!
    var profilePictureUrl: String?
    var country: String?
    var ref: DatabaseReference!
    var key: String! = ""
    var isVerified: Bool! = true
    var referencePhoto1: String?
    var referencePhoto2: String?
    var referencePhoto3: String?
    
    
    
    init(snapshot: DataSnapshot){
        
        self.email = (snapshot.value as! NSDictionary)["email"] as! String
        self.firstname = (snapshot.value as! NSDictionary)["firstname"] as? String
        self.lastname = (snapshot.value as! NSDictionary)["lastname"] as? String
        self.cosplayerID = (snapshot.value as! NSDictionary)["cosplayerID"] as? String
        self.uid = (snapshot.value as! NSDictionary)["uid"] as! String
        self.country = (snapshot.value as! NSDictionary)["country"] as? String
        self.profilePictureUrl = (snapshot.value as! NSDictionary)["profilePictureUrl"] as? String
        self.referencePhoto1 = (snapshot.value as! NSDictionary)["referencePhoto1"] as? String
        self.referencePhoto2 = (snapshot.value as! NSDictionary)["referencePhoto2"] as? String
        self.referencePhoto3 = (snapshot.value as! NSDictionary)["referencePhoto3"] as? String
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.isVerified = (snapshot.value as! NSDictionary)["isVerified"] as! Bool
    }
    
    
    init(email: String, firstname: String, lastname: String, uid: String, profilePictureUrl: String, referencePhoto1: String, referencePhoto2: String, referencePhoto3: String, country: String, cosplayerID: String){
        
        self.email = email
        self.firstname = firstname
        self.lastname = lastname
        self.cosplayerID = cosplayerID
        self.uid = uid
        self.profilePictureUrl = profilePictureUrl
        self.referencePhoto1 = referencePhoto1
        self.referencePhoto2 = referencePhoto2
        self.referencePhoto3 = referencePhoto3
        self.country = country
        self.ref = Database.database().reference()
    }
    
    func getFullname() -> String{
        
        return "\(String(describing: firstname)) \(String(describing: lastname))"
    }
    
    func toAnyObject() -> [String: Any]{
        return ["email":self.email,
                "firstname":self.firstname!,
                "lastname":self.lastname!,
                "cosplayerID":self.cosplayerID!,
                "country":self.country!,
                "uid":self.uid,
                "referencePhoto1":self.referencePhoto1!,
                "referencePhoto2": self.referencePhoto2!,
                "referencePhoto3":self.referencePhoto3!,
                "profilePictureUrl":profilePictureUrl!,
                "isVerified":self.isVerified]
    }
}
