//
//  VoterViewController.swift
//  Cosplayr
//
//  Created by Tony T. on 7/8/17.
//  Copyright © 2017 Phantom. All rights reserved.
//

import UIKit
import Firebase

class VoterViewController: UITableViewController {

    @IBOutlet var voterTableView: UITableView!
    
    var ref: DatabaseReference?
    var sections = [Section]()
    
    var conArray = [Convention]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target : self, action: #selector(handleCancel))
        
        fetchPlayers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func fetchPlayers() {
        Database.database().reference().child("conventions").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let section = Section()
                
                section.setValuesForKeys(dictionary)
                self.sections.append(section)
                
                DispatchQueue.main.async(execute: {
                    self.voterTableView.reloadData()
                })
            }
        })
    }
    
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //TABLE RELATED
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "conCell")
        
        let section = sections[indexPath.row]
        cell.textLabel?.text = section.coName
        cell.detailTextLabel?.text = section.country
        
        return cell
    }
    
    
    
    // MARK: - Navigation

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showCon" {
//            if let indexPath = tableView.indexPathForSelectedRow?.first {
//                let conVC = segue.destination as! ConventionDetailController
//                conVC.ref = conArray[indexPath].ref
//            }
//        }
//    }
    
    

}
