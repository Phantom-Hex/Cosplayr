//
//  ConventionDetailController.swift
//  Cosplayr
//
//  Created by Tony T. on 7/21/17.
//  Copyright © 2017 Phantom Hex. All rights reserved.
//

import UIKit
import Firebase

class ConventionDetailController: UITableViewController {

    
    var ref: DatabaseReference?
    var netService = NetService()
    
    @IBOutlet weak var conventionNameLabel: UILabel!
    @IBOutlet weak var conventionCountryLabel: UILabel!
    @IBOutlet weak var conventionImageView: UIImageView!
    @IBOutlet weak var conventionCoNameLabel: UILabel!
    
    @IBOutlet weak var cosplayerEntryCell: UITableViewCell!
    @IBAction func cosSignUpButton(_ sender: Any) {
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        setGuestConInfo()
    }
    
    private func setGuestConInfo() {
        if let ref = ref {
            netService.fetchGuestUser(ref: ref, completion: { (convention) in
                if let convention = convention {
                    self.conventionCoNameLabel.text = convention.firstname
                    self.conventionCountryLabel.text = convention.country
                    self.conventionNameLabel.text = "\(convention.firstname) \(convention.lastname)"
                    self.conventionImageView.sd_setImage(with: URL(string: convention.profilePictureUrl), placeholderImage: UIImage(named: "default"))
                }
            })
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
