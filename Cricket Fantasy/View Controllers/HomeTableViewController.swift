//
//  HomeTableViewController.swift
//  Cricket Fantasy
//
//  Created by student on 2/25/20.
//  Copyright © 2020 student. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        navigationItem.hidesBackButton = true
        navigationItem.title = "Matches"
        
        // Notification Whether Match added or not
        NotificationCenter.default.addObserver(self, selector: #selector(matchAdded(notification:)), name: NSNotification.Name(rawValue:"Match added"), object: nil)
        
        // Left Bar menu button
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .done, target: self, action: #selector(Menu))
    }
    
    // Left Bar menu button navigating to Menu Bar controller.
    @objc func Menu(){
        let menu = storyboard?.instantiateViewController(identifier: "SideMenu") as! SideMenuViewController
        //  navigationController?.pushViewController(menu, animated: true)
        menu.modalPresentationStyle = .formSheet
        self.show(menu, sender: nil)
    }
    
    // Reload the tabel View once notification is received
    @objc func matchAdded(notification:Notification){
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Tournaments.shared.numMatches()
    }
    
    // Tags for country names and logos
    let country1IMGTag = 100
    let country2IMGTag = 200
    let country1LBLTag = 300
    let country2LBLTag = 400
    
    let optimalRowHeight:CGFloat = 150
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return optimalRowHeight
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.masksToBounds = true
        
        // Get Tournaments
        let match = Tournaments.shared[indexPath.row]!
        let country1LBL = cell.viewWithTag(country1LBLTag) as! UILabel
        let country2LBL = cell.viewWithTag(country2LBLTag) as! UILabel
        let country1IMG = cell.viewWithTag(country1IMGTag) as! UIImageView
        let country2IMG = cell.viewWithTag(country2IMGTag) as! UIImageView
        
        // Assign the country names to labels
        country1LBL.text = match.team1
        country2LBL.text = match.team2
        
        //Assign country images
        if let image = UIImage(named: "\(match.team1).jpeg"){
            country1IMG.image = image
        }
        else{
            country1IMG.image = UIImage(named:"background.jpg")
        }
        
        if let image = UIImage(named: "\(match.team2).jpeg"){
            country2IMG.image = image
        }
        else{
            country2IMG.image = UIImage(named:"background.jpg")
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let match = Tournaments.shared[indexPath.row]!
        
        //Navigating to Players view
        let playersVC = storyboard?.instantiateViewController(identifier: "playersVC") as! SelectPlayersViewController
        
        playersVC.country1 = match.team1
        playersVC.country2 = match.team2
        playersVC.matchId = match.unique_id
        
        navigationController?.pushViewController(playersVC, animated: true)
        
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
