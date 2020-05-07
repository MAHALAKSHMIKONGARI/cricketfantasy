//
//  SelectPlayersViewController.swift
//  Cricket Fantasy
//
//  Created by student on 2/25/20.
//  Copyright © 2020 student. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SelectPlayersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var Choose: UISegmentedControl!
    
    //Database reference
    var playersref :DatabaseReference?
    
    // Used for Segmented Control selection
    var isbowler : Bool = true
    var isbatsman : Bool = false
    var iswkeeper: Bool = false
    var isallrounder: Bool = false
    
    // Number of matches that user is playing stored in database.
    static var matchnum = 0
    
    // store the matches to corresponding players
    static var postObj : [String: Any] = [:]
    
    // matchId
    var matchId  = 0
    
    @IBOutlet weak var country1IV: UIImageView!
    @IBOutlet weak var country2IV: UIImageView!
    @IBOutlet weak var country1LBL: UILabel!
    @IBOutlet weak var country2LBL: UILabel!
    
    @IBOutlet weak var tableView:UITableView!
    
    var country1 = ""
    var country2 = ""
    
    
    var nameLBLTag = 10
    var creditLBLTag = 20
    
    static var storedmatches : [Int] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        playersref = Database.database().reference()
        let user_ID = Auth.auth().currentUser!.uid
        
        // Fetch matches stored in database for corresponding user
        DatabaseStorage.shared.FectchMatchData(ref:playersref, userid: user_ID)
        
        //Check whether players are already selected for this match or not.
        DatabaseStorage.shared.NumberofMatchesInDatabase(ref:playersref, userid: user_ID, matchID: matchId)
        
        //Reset all players
        Players.shared.resetPlayers()
        Players.shared.fetchPlayers(matchID : matchId)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "CreateTeam", style: .done, target: self, action: #selector(CreateTeam))
        
        
        country1LBL.text = country1
        country2LBL.text = country2
        country1IV.image = UIImage(named: "\(country1).jpeg")
        country2IV.image = UIImage(named: "\(country2).jpeg")
        
        
        //Notification whether player is added or not.
        NotificationCenter.default.addObserver(self, selector: #selector(playerAdded(notification:)), name: NSNotification.Name(rawValue:"player added"), object: nil)
    }
    
    
    //Reload the table view once notification is received
    @objc func playerAdded(notification:Notification){
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    
    @objc func CreateTeam(){
        
        // Don't go to the Team View till players are selected
        if DatabaseStorage.shared.getBowlerCount() <= 3{
            showError("4 Bowlers required")
        }
        else if DatabaseStorage.shared.getBatsmanCount() <= 3{
            showError("4 Batsmans required")
        }
        else if DatabaseStorage.shared.getAllRounderCount() <= 1{
            showError("2 All rounders required")
        }
        else if DatabaseStorage.shared.getWicketKeeperCount() == 0{
            showError("1 WicketKeeper required")
        }
            
        else{
            
            var updated = false
            let userID = Auth.auth().currentUser?.uid
            
            //Strore selected team in Databsae
            let mat = [
                "matchID":  self.matchId,
                "players" :["bowlerscount" : DatabaseStorage.shared.getBowlerCount(),
                            "batsmancount" : DatabaseStorage.shared.getBatsmanCount(),
                            "WKcount" : DatabaseStorage.shared.getWicketKeeperCount(),
                            "ALLRoundercount" : DatabaseStorage.shared.getAllRounderCount(),
                            "bowler" : DatabaseStorage.shared.getSelectedBowlers(),
                            "batsman" : DatabaseStorage.shared.getSelectedBatsmans(),
                            "allrounder" : DatabaseStorage.shared.getSelectedAllRounders(),
                            "wiketkeeper" : DatabaseStorage.shared.getSelectedWicketKeepers()  ]]as [String :Any]
            
            // If the match is already in database and updating the changes
            for i in 0..<SelectPlayersViewController.matchnum{
                if SelectPlayersViewController.storedmatches[i] == self.matchId {
                    SelectPlayersViewController.postObj["match\(i)"] = mat
                    updated = true
                }
                
            }
            
            // If the match is newly storing in database
            if updated == false{
                SelectPlayersViewController.postObj["match\(SelectPlayersViewController.matchnum)"] = mat
                SelectPlayersViewController.matchnum  = SelectPlayersViewController.matchnum  + 1
            }
            
            // Database storage
            self.playersref?.child("users/\(userID!)/Matches").setValue( SelectPlayersViewController.postObj, withCompletionBlock: {error, ref in
                if error == nil {
                    self.dismiss(animated: true, completion: nil)
                }
            })
            
            // Navigationg to team view controller
            let next = storyboard?.instantiateViewController(identifier: "TVC") as! TeamViewController
            next.leagueref = playersref
            navigationController?.pushViewController(next, animated: true)
        }
    }
    
    let optimalRowHeight:CGFloat = 60
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return optimalRowHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //Based on sigamented Tap count will change
        if isallrounder == true{
            return Players.shared.getNumallRounders()
        }
        else if isbatsman == true{
            return Players.shared.getNumBatsmans()
        }
        else if iswkeeper == true{
            return Players.shared.getNumWicketKeepers()
        }
        else{
            return Players.shared.getNumBowlers()
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "players", for: indexPath)
        var player = ""
        
        let nameLBL = cell.viewWithTag(nameLBLTag) as! UILabel
        let selectButton = cell.viewWithTag(300) as! UIButton
        
        //If Batsmans are selected it shows as selected. otherwise it shows as not selected
        if isbatsman == true{
            player = Players.shared.getBatsmans()[indexPath.row]
            if DatabaseStorage.shared.getSelectedBatsmans().contains(player){
                selectButton.isSelected = true
            }else{
                selectButton.isSelected = false
            }
            
        }
            
            //If All Rounder are selected it shows as selected. otherwise it shows as not selected
        else if isallrounder == true{
            player = Players.shared.getAllRounders()[indexPath.row]
            if DatabaseStorage.shared.getSelectedAllRounders().contains(player){
                selectButton.isSelected = true
            }else{
                selectButton.isSelected = false
            }
            
        }
            
            //If Wicket keeper selected it shows as selected. otherwise it shows as not selected
        else if iswkeeper == true{
            player = Players.shared.getWicketKeepers()[indexPath.row]
            if DatabaseStorage.shared.getSelectedWicketKeepers().contains(player){
                selectButton.isSelected = true
            }else{
                selectButton.isSelected = false
            }
        }
            
            //If Bowlers are selected it shows as selected. otherwise it shows as not selected
        else{
            player = Players.shared.getBowlers()[indexPath.row]
            if DatabaseStorage.shared.getSelectedBowlers().contains(player){
                selectButton.isSelected = true
            }else{
                selectButton.isSelected = false
            }
        }
        
        nameLBL.text = player
        
        
        return cell
        
    }
    
    
    
    // Add or remove the players based on the button tap
    @IBAction func addPlayer(_ sender: UIButton) {
        
        
        if sender.isSelected{
            
            let point = sender.convert(CGPoint.zero, to: tableView)
            if isbowler {
                if let indexpath = tableView.indexPathForRow(at: point){
                    let index = DatabaseStorage.shared.getSelectedBowlers().firstIndex(of: Players.shared.getBowlers()[indexpath.row])!
                    DatabaseStorage.shared.deleteBowler(at: index)
                    DatabaseStorage.shared.decrementBowlerCount()
                    sender.isSelected = false
                }
            }
            if isbatsman {
                if let indexpath = tableView.indexPathForRow(at: point){
                    let index = DatabaseStorage.shared.getSelectedBatsmans().firstIndex(of: Players.shared.getBatsmans()[indexpath.row])!
                    DatabaseStorage.shared.deleteBatsman(at: index)
                    DatabaseStorage.shared.decrementBatsmanCount()
                    sender.isSelected = false
                    
                }
            }
            if iswkeeper{
                if let indexpath = tableView.indexPathForRow(at: point){
                    let index =  DatabaseStorage.shared.getSelectedWicketKeepers().firstIndex(of: Players.shared.getWicketKeepers()[indexpath.row])!
                    DatabaseStorage.shared.deleteWicketKeeper(at: index)
                    DatabaseStorage.shared.decrementWkeeperCount()
                    sender.isSelected = false
                    
                }
            }
            if isallrounder {
                if let indexpath = tableView.indexPathForRow(at: point){
                    let index = DatabaseStorage.shared.getSelectedAllRounders().firstIndex(of: Players.shared.getAllRounders()[indexpath.row])!
                    DatabaseStorage.shared.deleteAllRounder(at: index)
                    DatabaseStorage.shared.decrementAllRounderCount()
                    sender.isSelected = false
                }
            }
        }
        else{
            
            let point = sender.convert(CGPoint.zero, to: tableView)
            
            if isbowler && DatabaseStorage.shared.getBowlerCount() <= 3{
                if let indexpath = tableView.indexPathForRow(at: point){
                    DatabaseStorage.shared.addSelectedBowler(bowlerName: Players.shared.getBowlers()[indexpath.row])
                    DatabaseStorage.shared.incrementBowlerCount()
                    sender.isSelected = true
                }
            }
            
            if isbatsman && DatabaseStorage.shared.getBatsmanCount() <= 3{
                if let indexpath = tableView.indexPathForRow(at: point){
                    DatabaseStorage.shared.addSelectedBatsmans(batsmanName: Players.shared.getBatsmans()[indexpath.row])
                    DatabaseStorage.shared.incrementBatsmanCount()
                    sender.isSelected = true
                    
                }
            }
            if iswkeeper && DatabaseStorage.shared.getWicketKeeperCount() <= 0{
                if let indexpath = tableView.indexPathForRow(at: point){
                    DatabaseStorage.shared.addSelectedWicketKeeper(wKeeperName: Players.shared.getWicketKeepers() [indexpath.row])
                    DatabaseStorage.shared.incrementWKeeperCount()
                    sender.isSelected = true
                    
                }
            }
            if isallrounder  && DatabaseStorage.shared.getAllRounderCount() <= 1 {
                if let indexpath = tableView.indexPathForRow(at: point){
                    DatabaseStorage.shared.addSelectedAllRounder(allRounderName: Players.shared.getAllRounders() [indexpath.row])
                    DatabaseStorage.shared.incrementAllRounderCount()
                    
                    sender.isSelected = true
                    
                }
            }
            
        }
        
        
    }
    
    //Based on Segament Tap will get to know which table is highligthed
    @IBAction func SegmentTapped(_ sender: Any) {
        
        let getIndex = Choose.selectedSegmentIndex
        
        switch getIndex {
        case 0:
            isbatsman = false
            iswkeeper = false
            isbowler = true
            isallrounder = false
            self.tableView.reloadData()
        case 1:
            isbowler = false
            iswkeeper = false
            isallrounder = false
            isbatsman = true
            self.tableView.reloadData()
        case 2:
            isbowler = false
            iswkeeper = false
            isallrounder = true
            isbatsman = false
            self.tableView.reloadData()
        case 3:
            isbowler = false
            iswkeeper = true
            isallrounder = false
            isbatsman = false
            self.tableView.reloadData()
        default:
            break
        }
        
    }
    
    //Alert Message
    func showError(_ title: String){
        let ac = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        ac.addAction(action)
        self.present(ac, animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
