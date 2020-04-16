//
//  MyLeagueTableViewController.swift
//  Cricket Fantasy
//
//  Created by student on 4/14/20.
//  Copyright © 2020 student. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class MyLeagueTableViewController: UITableViewController {

    var leagueref :DatabaseReference?
    var leagues : [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "My leagues"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leagues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

     //  print(self.leagues)
        
       // var key   = Array(self.leagues.keys)[indexPath.row]
        let leagueDetails = Array(self.leagues.values)[indexPath.row] as! [String :Any]
       
        let name = leagueDetails["Team Name"] as? String
        let leagID = leagueDetails["leagID"] as? UInt32
        let teamNameLBL = cell.viewWithTag(100) as! UILabel
        let teamCodeLBL = cell.viewWithTag(200) as! UILabel
        
        teamNameLBL.text = name!
        teamCodeLBL.text = "\(leagID!)"
        

        // Configure the cell...
       // cell.textLabel?.text = "\(league)"

        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
         //  let match = Tournaments.shared[indexPath.row]!
           let leagueDetails = Array(self.leagues.values)[indexPath.row] as! [String :Any]
           let playersTVC = storyboard?.instantiateViewController(identifier: "LeaguePlayersTableViewController") as! LeaguePlayersTableViewController
           
            let leagID = leagueDetails["leagID"] as? UInt32
            
            self.leagueref?.child("leagues").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let leaguecount = value?.count ?? 0
            
            
            for i in 0..<leaguecount{
                self.leagueref?.child("leagues/league\(i)").observeSingleEvent(of: .value, with: { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    let id =  value?["leagID"] as? UInt32 ?? 0
                    let name = value?["Team Name"] as? String ?? ""
                    let players = value?["players"] as? [String] ?? []
                    
                    if id == leagID {
                        print(players)
                        playersTVC.players = players
                        print( playersTVC.players)
                        NotificationCenter.default.post(name: NSNotification.Name("Match added"), object: nil)
                    }
              })
             }
            })
           navigationController?.pushViewController(playersTVC, animated: true)
           
       }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
