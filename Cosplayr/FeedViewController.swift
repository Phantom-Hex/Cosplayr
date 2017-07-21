//
//  FeedViewController.swift
//  Cosplayr
//
//  Created by Tony T. on 7/19/17.
//  Copyright © 2017 Phantom Hex. All rights reserved.
//

import UIKit

import UIKit
//import HMSegmentedControl
import Firebase

class FeedViewController: UIViewController {
    
    //MARK: Outlets
    
    
    
    
    var databaseRef: DatabaseReference! {
        
        return Database.database().reference()
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet {
            collectionView.alpha = 1
        }
    }
    
    var usersArray = [User]()
    var netService = NetService()
    var postsArray = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fetchAllUsers()
        fetchAllPosts()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 592
    }
    
    private func fetchAllUsers(){
        netService.fetchAllUsers { (users) in
            self.usersArray = users
            self.collectionView.reloadData()
        }
    }
    
    private func fetchAllPosts(){
        netService.fetchAllPosts {(posts) in
            self.postsArray = posts
            self.postsArray.sort(by: { (post1, post2) -> Bool in
                Int(post1.postDate) > Int(post2.postDate)
            })
            
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func commentPostWithImageAction(_ sender: UIButton) {
        performSegue(withIdentifier: "showComments", sender: sender)
    }
    
    @IBAction func commentPostWithTextAction(_ sender: Any) {
        performSegue(withIdentifier: "showComments", sender: sender)
        
    }
    @IBAction func logOutAction(_ sender: UIButton) {
        netService.logOut {
            let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") as! LoginViewController
            loginVC.modalTransitionStyle = .crossDissolve
            self.present(loginVC, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func unwindToHome(storyboardSegue: UIStoryboardSegue){}
}


extension FeedViewController: UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    struct CellIdentifiers {
        var userCell = "userCell"
        var postImageCell = "imageCell"
        var postTextCell = "textCell"
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if postsArray[indexPath.row].type == "IMAGE" {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers().postImageCell, for: indexPath) as! PostImageTableViewCell
            cell.configureCell(post:postsArray[indexPath.row])
            cell.commentButton.tag = indexPath.row
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers().postTextCell, for: indexPath) as! PostTextTableViewCell
            cell.configureCell(post:postsArray[indexPath.row])
            cell.commentButton.tag = indexPath.row
            
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGuest" {
            if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                let guestVC = segue.destination as! GuestUserViewController
                guestVC.ref = usersArray[indexPath.row].ref
            }
        }else if segue.identifier == "showComments" {
            let sender = sender as? UIButton
            if let indexPath = sender?.tag  {
                let commentsVC = segue.destination as! CommentsTableViewController
                commentsVC.post = self.postsArray[indexPath]
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.usersArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers().userCell, for: indexPath) as! UserCollectionViewCell
        cell.configureCellForUser(user: self.usersArray[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showGuest", sender: self)
        
    }
    
}


