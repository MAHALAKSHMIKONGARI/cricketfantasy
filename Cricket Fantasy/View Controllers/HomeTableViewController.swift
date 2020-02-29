//
//  HomeTableViewController.swift
//  Cricket Fantasy
//
//  Created by student on 2/25/20.
//  Copyright © 2020 student. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var match : Match!

    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        
        navigationItem.hidesBackButton = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
         navigationItem.title = "Matches"
               
       
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
        return Matches.shared.numMatches()
    }
    
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
           if let match = Matches.shared[indexPath.row]{
               
               let country1LBL = cell.viewWithTag(country1LBLTag) as! UILabel
               let country2LBL = cell.viewWithTag(country2LBLTag) as! UILabel
               let country1IMG = cell.viewWithTag(country1IMGTag) as! UIImageView
               let country2IMG = cell.viewWithTag(country2IMGTag) as! UIImageView
            
            
            country1LBL.text = match.country1
            country2LBL.text = match.country2
            
              
            if let image = UIImage(named: "\(match.country1).jpeg"){
                    country1IMG.image = image
               }
               else{
                   country1IMG.image = UIImage(named:"background.jpg")
               }
            
            if let image = UIImage(named: "\(match.country2).jpeg"){
                 country2IMG.image = image
            }
            else{
                country2IMG.image = UIImage(named:"background.jpg")
            }
            
           }
           
           return cell
       }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        let playersVC = storyboard?.instantiateViewController(identifier: "playersVC") as! SelectPlayersViewController
        if let match = Matches.shared[indexPath.row]{
            
            playersVC.country1 =  match.country1
            playersVC.country2 = match.country2
            playersVC.country1Img = UIImage(named: "\(match.country1).jpeg")!
            playersVC.country2Img = UIImage(named: "\(match.country2).jpeg")!
        
        }

        playersVC.match = Matches.shared[indexPath.row]
        
        
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
