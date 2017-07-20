//
//  VoterViewController.swift
//  Cosplayr
//
//  Created by Tony T. on 7/8/17.
//  Copyright © 2017 Phantom. All rights reserved.
//

import UIKit
import Firebase

class VoterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ExpandableHeaderViewDelegate {

    @IBOutlet var voterTableView: UITableView!
    var sections = [Section]()
    
    

 /*
     var sections = [
        Section(convention: "Ohio Area", cons: ["FandomFest", "Ohayocon", "Animatic Con", "A&G Con"], expanded: false),
        Section(convention: "NC Area", cons: ["Animazement", "Tri-City Con"], expanded: false),
        Section(convention: "California Area", cons: ["Anime Expo","NinjaCon","Anime los Angeles"], expanded: false)
    ]
 */
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
    
    
    
    //TABLE RELATED
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(sections[indexPath.section].expanded){
            return 44
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.customInit(title: sections[section].convention!, section: section, delegate: self)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell")!
        cell.textLabel?.text = sections[indexPath.section].cosplayer
        return cell
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        
        voterTableView.beginUpdates()
        for i in 0 ..< sections.count {
            voterTableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        voterTableView.endUpdates()
    }
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
