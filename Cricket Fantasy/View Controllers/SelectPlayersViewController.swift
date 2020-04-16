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
    
    var playersref :DatabaseReference?
    
  //  var match : Match!
    var squad = [Squads]()
   // var players = [Player]()
    
    var newView = false
    var isbowler : Bool = true
    var isbatsman : Bool = false
    var iswkeeper: Bool = false
    var isallrounder: Bool = false
    
    static var matchnum = 0
    static var postObj : [String: Any] = [:]
    var id  = 0
    var matchId  = 0
    var matched = false
    var getmatchnum = false
    @IBOutlet weak var country1IV: UIImageView!
    @IBOutlet weak var country2IV: UIImageView!
    @IBOutlet weak var country1LBL: UILabel!
    @IBOutlet weak var country2LBL: UILabel!
    @IBOutlet weak var tableView:UITableView!
    
    var country1 = ""
    var country2 = ""
    var country1Img = UIImage()
    var country2Img = UIImage()
    
    var nameLBLTag = 10
    var creditLBLTag = 20
    
    static var storedmatches : [Int] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        playersref = Database.database().reference()
        let user_ID = Auth.auth().currentUser!.uid
               
               DatabaseStorage.shared.FectchMatchData(ref:playersref, userid: user_ID)
               DatabaseStorage.shared.NumberofMatchesInDatabase(ref:playersref, userid: user_ID, matchID: matchId  ){ success in
                   if success{
                   }
                       
                   else{
                       print("out")
                   }
               }
        
        Players.shared.resetPlayers()
        Players.shared.fetchPlayers(matchID : matchId)
        
                
       
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background.jpg")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(Next))
        
        country1LBL.text = country1
        country2LBL.text = country2
        country1IV.image = country1Img
        country2IV.image = country2Img
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerAdded(notification:)), name: NSNotification.Name(rawValue:"player added"), object: nil)
    }
    
    @objc func playerAdded(notification:Notification){
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
               
    }
    
    @objc func Next(){
        
        var updated = false
        
        let userID = Auth.auth().currentUser?.uid
        
        let mat = [
            // "Matches" :[
            "matchID":  self.matchId,
            "players" :["bowlerscount" : DatabaseStorage.shared.getBowlerCount(),
                        "batsmancount" : DatabaseStorage.shared.getBatsmanCount(),
                        "WKcount" : DatabaseStorage.shared.getWicketKeeperCount(),
                        "ALLRoundercount" : DatabaseStorage.shared.getAllRounderCount(),
                        "bowler" : DatabaseStorage.shared.getSelectedBowlers(),
                        "batsman" : DatabaseStorage.shared.getSelectedBatsmans(),
                        "allrounder" : DatabaseStorage.shared.getSelectedAllRounders(),
                        "wiketkeeper" : DatabaseStorage.shared.getSelectedWicketKeepers()  ]]as [String :Any]
       
        for i in 0..<SelectPlayersViewController.matchnum{
            if SelectPlayersViewController.storedmatches[i] == self.matchId {
                print(SelectPlayersViewController.storedmatches[i] )
                SelectPlayersViewController.postObj["match\(i)"] = mat
                updated = true
            }
            
        }
        
        if updated == false{
            SelectPlayersViewController.postObj["match\(SelectPlayersViewController.matchnum)"] = mat
            SelectPlayersViewController.matchnum  = SelectPlayersViewController.matchnum  + 1
        }
        
        self.playersref?.child("users/\(userID!)/Matches").setValue( SelectPlayersViewController.postObj, withCompletionBlock: {error, ref in
            if error == nil {
                
                self.dismiss(animated: true, completion: nil)
            }else{
                
            }
        })
        

        let next = storyboard?.instantiateViewController(identifier: "TVC") as! TeamViewController
        next.leagueref = playersref
        
        navigationController?.pushViewController(next, animated: true)
        
    }
    
    let optimalRowHeight:CGFloat = 60
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return optimalRowHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
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
        let creditLBL  = cell.viewWithTag(creditLBLTag) as! UILabel
        let selectButton = cell.viewWithTag(300) as! UIButton
        
        if isbatsman == true{
            player = Players.shared.getBatsmans()[indexPath.row]
            if DatabaseStorage.shared.getSelectedBatsmans().contains(player){
                selectButton.isSelected = true
            }else{
                selectButton.isSelected = false
            }
            
        }
        else if isallrounder == true{
            player = Players.shared.getAllRounders()[indexPath.row]
            if DatabaseStorage.shared.getSelectedAllRounders().contains(player){
                selectButton.isSelected = true
            }else{
                selectButton.isSelected = false
            }
            
        }
        else if iswkeeper == true{
            player = Players.shared.getWicketKeepers()[indexPath.row]
            if DatabaseStorage.shared.getSelectedWicketKeepers().contains(player){
                selectButton.isSelected = true
            }else{
                selectButton.isSelected = false
            }
        }
        else{
            player = Players.shared.getBowlers()[indexPath.row]
            if DatabaseStorage.shared.getSelectedBowlers().contains(player){
                selectButton.isSelected = true
            }else{
                selectButton.isSelected = false
            }
        }
        // selectButton.isSelected = false
        
        
        nameLBL.text = player
        // creditLBL.text = "\(Player.)"
        
        return cell
        
    }
    
    
    
    
    @IBAction func addPlayer(_ sender: UIButton) {
        print("bowlers")
        print(SelectPlayersViewController.postObj)
        print(DatabaseStorage.shared.getSelectedBowlers())
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
                }else{
                    showError("You can't have more than 4 BOWLERS")
                }
            }
            
            if isbatsman && DatabaseStorage.shared.getBatsmanCount() <= 3{
                if let indexpath = tableView.indexPathForRow(at: point){
                    DatabaseStorage.shared.addSelectedBatsmans(batsmanName: Players.shared.getBatsmans()[indexpath.row])
                    DatabaseStorage.shared.incrementBatsmanCount()
                    sender.isSelected = true
                    
                }
                else{
                    showError("You can't have more than 4 BATSMAN")
                }
            }
            if iswkeeper && DatabaseStorage.shared.getWicketKeeperCount() <= 0{
                if let indexpath = tableView.indexPathForRow(at: point){
                    DatabaseStorage.shared.addSelectedWicketKeeper(wKeeperName: Players.shared.getWicketKeepers() [indexpath.row])
                    DatabaseStorage.shared.incrementWKeeperCount()
                    sender.isSelected = true
                    
                }else{
                    showError("You can't have more than 1 WICKET KEEPERS")
                }
            }
            if isallrounder  && DatabaseStorage.shared.getAllRounderCount() <= 1 {
                if let indexpath = tableView.indexPathForRow(at: point){
                    DatabaseStorage.shared.addSelectedAllRounder(allRounderName: Players.shared.getAllRounders() [indexpath.row])
                    DatabaseStorage.shared.incrementAllRounderCount()
                    
                    sender.isSelected = true
                    
                }else{
                    showError("You can't have more than 2 ALL ROUNDERS")
                }
            }
            
        }
        
        
    }
    
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
