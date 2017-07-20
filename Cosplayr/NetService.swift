//
//  NetworkingService.swift
//  Cosplayr
//
//  Created by Tony T. on 7/19/17.
//  Copyright © 2017 Phantom Hex. All rights reserved.
//

import Foundation
import Firebase
import GameKit


struct NetService {
    
    var databaseRef: DatabaseReference! {
        
        return Database.database().reference()
    }
    
    var storageRef: StorageReference! {
        
        return Storage.storage().reference()
    }
    
    
    
    
    func signUp(firstname: String, lastname:String, country:String, email: String,pictureData: Data,password:String){
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                print(error.localizedDescription)
            }else {
                
                self.setUserInfo(user: user!, firstname: firstname, lastname: lastname, country: country, pictureData: pictureData,password: password)
                
            }
        })
        
    }
    
    private func setUserInfo(user: Firebase.User, firstname: String, lastname:String, country:String,pictureData: Data,password: String){
        
        let profilePicturePath = "profileImage\(user.uid)image.jpg"
        let profilePictureRef = storageRef.child(profilePicturePath)
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        profilePictureRef.putData(pictureData, metadata: metaData) { (newMetadata, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = "\(firstname) \(lastname)"
                
                if let url = newMetadata?.downloadURL() {
                    changeRequest.photoURL = url
                }
                
                changeRequest.commitChanges(completion: { (error) in
                    if error == nil {
                        
                        self.saveUserInfoToDb(user: user, firstname: firstname, lastname: lastname, country: country,password: password)
                        
                        
                    }else {
                        print(error!.localizedDescription)
                    }
                })
                
            }
        }
    }
    
    
    
    private func saveUserInfoToDb(user: Firebase.User, firstname: String, lastname:String, country:String,password: String){
        
        
        let userRef = databaseRef.child("users").child(user.uid)
        let newUser = User(email: user.email!, firstname: firstname, lastname: lastname, uid: user.uid, profilePictureUrl: String(describing: user.photoURL!), country: country)
        
        userRef.setValue(newUser.toAnyObject()) { (error, ref) in
            if error == nil {
                print("\(firstname) \(lastname) has been signed up successfully")
            }else {
                print(error!.localizedDescription)
            }
        }
        self.signIn(email: user.email!, password: password)
    }
    
    
    //COSPLAYER RELATED
    func signUpCosplayer(firstname: String, lastname:String, country:String, email: String,pictureData: Data, referencePic1Data: Data, referencePic2Data: Data, referencePic3Data: Data, password: String, cosplayerID: String){
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                
                self.setCosplayerInfo(user: user!, firstname: firstname, lastname: lastname, country: country, pictureData: pictureData, referencePic1Data: referencePic1Data, referencePic2Data: referencePic2Data, referencePic3Data: referencePic3Data, password: password, cosplayerID: cosplayerID)
            }
        })
        
    }
    
    private func setCosplayerInfo(user: Firebase.User, firstname: String, lastname:String, country:String,pictureData: Data, referencePic1Data: Data, referencePic2Data: Data, referencePic3Data: Data, password: String, cosplayerID: String){
        
        let profilePicturePath = "profileImage\(user.uid)image.jpg"
        let profilePictureRef = storageRef.child(profilePicturePath)
        let ref1Path = "referenceImages1\(user.uid)image.jpg"
        let ref1Ref = storageRef.child(ref1Path)
        let ref2Path = "referenceImages2\(user.uid)image.jpg"
        let ref2Ref = storageRef.child(ref2Path)
        let ref3Path = "referenceImages3\(user.uid)image.jpg"
        let ref3Ref = storageRef.child(ref3Path)
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"

        
        ref1Ref.putData(referencePic1Data, metadata: metaData) { (newMetadata, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = "\(firstname) \(lastname)"
                
                if let url1 = newMetadata?.downloadURL() {
                    changeRequest.photoURL = url1
                }
                
                changeRequest.commitChanges(completion: { (error) in
                    if error == nil {
                        
                        self.saveCosplayerInfoToDb(user: user, firstname: firstname, lastname: lastname, country: country, password: password, cosplayerID: cosplayerID)
                        
                    }else {
                        print(error!.localizedDescription)
                    }
                })
                
            }
        }
        ref2Ref.putData(referencePic2Data, metadata: metaData) { (newMetadata, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = "\(firstname) \(lastname)"
                
                if let url2 = newMetadata?.downloadURL() {
                    changeRequest.photoURL = url2
                }
                
                changeRequest.commitChanges(completion: { (error) in
                    if error == nil {
                        
                        self.saveCosplayerInfoToDb(user: user, firstname: firstname, lastname: lastname, country: country, password: password, cosplayerID: cosplayerID)
                        
                    }else {
                        print(error!.localizedDescription)
                    }
                })
                
            }
        }
        ref3Ref.putData(referencePic3Data, metadata: metaData) { (newMetadata, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = "\(firstname) \(lastname)"
                
                if let url3 = newMetadata?.downloadURL() {
                    changeRequest.photoURL = url3
                }
                
                changeRequest.commitChanges(completion: { (error) in
                    if error == nil {
                        
                        self.saveCosplayerInfoToDb(user: user, firstname: firstname, lastname: lastname, country: country, password: password, cosplayerID: cosplayerID)
                        
                    }else {
                        print(error!.localizedDescription)
                    }
                })
                
            }
        }
        
        profilePictureRef.putData(pictureData, metadata: metaData) { (newMetadata, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = "\(firstname) \(lastname)"
                
                if let url = newMetadata?.downloadURL() {
                    changeRequest.photoURL = url
                }
                
                changeRequest.commitChanges(completion: { (error) in
                    if error == nil {
                        
                        self.saveCosplayerInfoToDb(user: user, firstname: firstname, lastname: lastname, country: country, password: password, cosplayerID: cosplayerID)
                        
                    }else {
                        print(error!.localizedDescription)
                    }
                })
                
            }
        }
    }
    
    
    private func saveCosplayerInfoToDb(user: Firebase.User, firstname: String, lastname:String, country:String,password: String, cosplayerID: String){
        
        
        let cosplayerRef = databaseRef.child("conventions").childByAutoId().child("cosplayers").child(user.uid)
        let newCosplayer = Cosplayer(email: user.email!, firstname: firstname, lastname: lastname, uid: (Auth.auth().currentUser?.uid)!, profilePictureUrl: String(describing: user.photoURL), referencePhoto1: String(describing: user.photoURL), referencePhoto2: String(describing: user.photoURL), referencePhoto3: String(describing: user.photoURL), country: country, cosplayerID: cosplayerID)
        
        cosplayerRef.setValue(newCosplayer.toAnyObject()) { (error, ref) in
            if error == nil {
                print("\(firstname) \(lastname) has been registered successfully!")
            }else {
                print(error!.localizedDescription)
            }
        }
        self.signIn(email: user.email!, password: password)
    }
    
    
    // SIGNING IN
    
    func signIn(email: String, password: String){
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                if let user = user {
                    print("\(user.displayName!) has logged in successfully!")
                    
                    let appDel = UIApplication.shared.delegate as! AppDelegate
                    appDel.takeToHome()
                }
                
            }else {
                print(error!.localizedDescription)
                
            }
        })
        
    }
    
    // RANDOMIZER
    
    func randomGen() -> String {
        let randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: 1000)
        return String(randomNumber)
    }
    
    //POST RELATED
    func fetchAllPosts(completion: @escaping ([Post])->()){
        
        let postsRef = databaseRef.child("posts")
        postsRef.observe(.value, with: { (posts) in
            
            var resultArray = [Post]()
            for post in posts.children {
                
                let post = Post(snapshot: post as! DataSnapshot)
                resultArray.append(post)
            }
            completion(resultArray)
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    func fetchAllComments(postId: String, completion: @escaping ([Comment])->()){
        
        let commentsRef = databaseRef.child("comments").queryOrdered(byChild: "postId").queryEqual(toValue: postId)
        
        commentsRef.observe(.value, with: { (comments) in
            
            var resultArray = [Comment]()
            for comment in comments.children {
                
                let comment = Comment(snapshot: comment as! DataSnapshot)
                resultArray.append(comment)
            }
            completion(resultArray)
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    func fetchNumberOfComments(postId: String, completion: @escaping (Int)->()){
        
        let commentsRef = databaseRef.child("comments").queryOrdered(byChild: "postId").queryEqual(toValue: postId)
        
        commentsRef.observe(.value, with: { (comments) in
            
            completion(Int(comments.childrenCount))
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    func fetchPostUserInfo(uid: String, completion: @escaping (User?)->()){
        
        
        let userRef = databaseRef.child("users").child(uid)
        
        userRef.observeSingleEvent(of: .value, with: { (currentUser) in
            
            let user: User = User(snapshot: currentUser)
            completion(user)
            
            
            
            
        }) { (error) in
            print(error.localizedDescription)
            
        }
        
        
    }
    
    func fetchAllUsers(completion: @escaping([User])->Void){
        
        let usersRef = databaseRef.child("users")
        usersRef.observe(.value, with: { (users) in
            
            var resultArray = [User]()
            for user in users.children {
                
                let user = User(snapshot: user as! DataSnapshot)
                let currentUser = Auth.auth().currentUser!
                
                if user.uid != currentUser.uid {
                    resultArray.append(user)
                }
                completion(resultArray)
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
    }
    
    func logOut(completion: ()->()){
        
        
        if Auth.auth().currentUser != nil {
            
            do {
                
                try Auth.auth().signOut()
                completion()
            }
                
            catch let error {
                print("Failed to log out user: \(error.localizedDescription)")
            }
        }
        
        
    }
    
    func fetchCurrentUser(completion: @escaping (User?)->()){
        
        let currentUser = Auth.auth().currentUser!
        
        let currentUserRef = databaseRef.child("users").child(currentUser.uid)
        
        currentUserRef.observeSingleEvent(of: .value, with: { (currentUser) in
            
            let user: User = User(snapshot: currentUser)
            completion(user)
            
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func fetchGuestUser(ref:DatabaseReference!, completion: @escaping (User?)->()){
        
        
        ref.observeSingleEvent(of: .value, with: { (currentUser) in
            
            let user: User = User(snapshot: currentUser)
            completion(user)
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func downloadImageFromFirebase(urlString: String, completion: @escaping (UIImage?)->()){
        
        let storageRef = Storage.storage().reference(forURL: urlString)
        storageRef.getData(maxSize: 1 * 1024 * 1024) { (imageData, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                
                if let data = imageData {
                    completion(UIImage(data:data))
                    
                }
            }
        }
        
        
    }
    
    func savePostToDB(post: Post, completed: @escaping ()->Void){
        
        let postRef = databaseRef.child("posts").childByAutoId()
        postRef.setValue(post.toAnyObject()) { (error, ref) in
            if let error = error {
                print(error.localizedDescription)
            }else {
                let alertView = SCLAlertView()
                _ = alertView.showSuccess("Success", subTitle: "Post saved successfuly", closeButtonTitle: "Done", duration: 4, colorStyle: UIColor(colorWithHexValue: 0x3D5B94), colorTextButton: UIColor.white)
                completed()
            }
        }
        
    }
    
    func saveCommentToDB(comment: Comment, completed: @escaping ()->Void){
        
        let postRef = databaseRef.child("comments").childByAutoId()
        postRef.setValue(comment.toAnyObject()) { (error, ref) in
            if let error = error {
                print(error.localizedDescription)
            }else {
                let alertView = SCLAlertView()
                _ = alertView.showSuccess("Success", subTitle: "Comment saved successfuly", closeButtonTitle: "Done", duration: 4, colorStyle: UIColor(colorWithHexValue: 0x3D5B94), colorTextButton: UIColor.white)
                completed()
            }
        }
        
    }
    
    func uploadImageToFirebase(postId: String,imageData: Data, completion: @escaping (URL)->()){
        
        let postImagePath = "postImages/\(postId)image.jpg"
        let postImageRef = storageRef.child(postImagePath)
        let postImageMetadata = StorageMetadata()
        postImageMetadata.contentType = "image/jpeg"
        
        
        postImageRef.putData(imageData, metadata: postImageMetadata) { (newPostImageMD, error) in
            if let error = error {
                print(error.localizedDescription)
            }else {
                if let postImageURL = newPostImageMD?.downloadURL() {
                    completion(postImageURL)
                }
            }
        }
        
    }
    
    
}
