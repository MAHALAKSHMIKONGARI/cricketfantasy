//
//  TeamViewController.swift
//  Cricket Fantasy
//
//  Created by student on 3/17/20.
//  Copyright © 2020 student. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
class TeamViewController: UIViewController {
    
    var leagueref :DatabaseReference?
    var postleague : [String: Any] = [:]
    var leaguecount : Int = 0
    var myLeagues : [String: Any] = [:]
    var myleaguecount = 0
    
    
    
    @IBOutlet weak var bowler1IMG: UIImageView!
    @IBOutlet weak var bowler1LBL: UILabel!
    @IBOutlet weak var bowler2LBL: UILabel!
    @IBOutlet weak var bowler2IMG: UIImageView!
    @IBOutlet weak var bowler3LBL: UILabel!
    @IBOutlet weak var bowler3IMG: UIImageView!
    @IBOutlet weak var bowler4LBL: UILabel!
    @IBOutlet weak var bowler4IMG: UIImageView!
    
    
    @IBOutlet weak var batsman1LBL: UILabel!
    @IBOutlet weak var batsman1IMG: UIImageView!
    @IBOutlet weak var batsman2LBL: UILabel!
    @IBOutlet weak var batsman2IMG: UIImageView!
    @IBOutlet weak var batsman3LBL: UILabel!
    @IBOutlet weak var batsman3IMG: UIImageView!
    @IBOutlet weak var batsman4LBL: UILabel!
    @IBOutlet weak var batsman4IMG: UIImageView!
    
    @IBOutlet weak var allRounder1LBL: UILabel!
    @IBOutlet weak var allRounder1IMG: UIImageView!
    @IBOutlet weak var allRounder2LBL: UILabel!
    @IBOutlet weak var allRounder2IMG: UIImageView!
    @IBOutlet weak var wKeeperLBL: UILabel!
    @IBOutlet weak var wKeeperIMG: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //We will get all the leagues in the database and check wthether that league is there in database or not.
        checkLeagueIsContain(teamID : 123456)
        
        //get the leagues that you joined or created
        getYourLeagues()
        
        //Get the League Count from the database
        leagueref?.child("leagues").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.leaguecount = value?.count ?? 0
            
        }){ (error) in
            print(error.localizedDescription)
        }
        
        // Load all the player names and images to the lables and images
        if DatabaseStorage.shared.getBowlerCount() == 0 {
            bowler1LBL.text = "Not selected"
            bowler2LBL.text = "Not selected"
            bowler3LBL.text = "Not selected"
            bowler4LBL.text = "Not selected"
        }
        else{
            
            bowler1IMG.image = UIImage(data: Players.shared.getPlayerImage(name: DatabaseStorage.shared.getSelectedBowlers()[0])!)
            bowler1LBL.text = DatabaseStorage.shared.getSelectedBowlers()[0]
            bowler2IMG.image = UIImage(data: Players.shared.getPlayerImage(name: DatabaseStorage.shared.getSelectedBowlers()[1])!)
            bowler2LBL.text = DatabaseStorage.shared.getSelectedBowlers()[1]
            bowler3IMG.image = UIImage(data: Players.shared.getPlayerImage(name: DatabaseStorage.shared.getSelectedBowlers()[2])!)
            bowler3LBL.text = DatabaseStorage.shared.getSelectedBowlers()[2]
            bowler4IMG.image = UIImage(data: Players.shared.getPlayerImage(name: DatabaseStorage.shared.getSelectedBowlers()[3])!)
            bowler4LBL.text = DatabaseStorage.shared.getSelectedBowlers()[3]
        }
        
        if DatabaseStorage.shared.getBatsmanCount() == 0{
            batsman1LBL.text = "Not selected"
            batsman2LBL.text = "Not selected"
            batsman3LBL.text = "Not selected"
            batsman4LBL.text = "Not selected"
        }
        else{
            
            batsman1IMG.image = UIImage(data: Players.shared.getPlayerImage(name: DatabaseStorage.shared.getSelectedBatsmans()[0])!)
            batsman1LBL.text = DatabaseStorage.shared.getSelectedBatsmans()[0]
            batsman2IMG.image = UIImage(data: Players.shared.getPlayerImage(name: DatabaseStorage.shared.getSelectedBatsmans()[1])!)
            batsman2LBL.text = DatabaseStorage.shared.getSelectedBatsmans()[1]
            batsman3IMG.image = UIImage(data: Players.shared.getPlayerImage(name: DatabaseStorage.shared.getSelectedBatsmans()[2])!)
            batsman3LBL.text = DatabaseStorage.shared.getSelectedBatsmans()[2]
            batsman4IMG.image = UIImage(data: Players.shared.getPlayerImage(name: DatabaseStorage.shared.getSelectedBatsmans()[3])!)
            batsman4LBL.text = DatabaseStorage.shared.getSelectedBatsmans()[3]
        }
        
        if DatabaseStorage.shared.getAllRounderCount() == 0{
            
            allRounder1LBL.text = "Not selected"
            allRounder2LBL.text = "Not selected"
        }
        else{
            allRounder1IMG.image = UIImage(data: Players.shared.getPlayerImage(name: DatabaseStorage.shared.getSelectedAllRounders()[0])!)
            allRounder1LBL.text = DatabaseStorage.shared.getSelectedAllRounders()[0]
            allRounder1IMG.image = UIImage(data: Players.shared.getPlayerImage(name: DatabaseStorage.shared.getSelectedAllRounders()[1])!)
            allRounder2LBL.text = DatabaseStorage.shared.getSelectedAllRounders()[1]
        }
        
        
        if DatabaseStorage.shared.getWicketKeeperCount() == 0 {
            wKeeperLBL.text = "Not selected"
        }
        else{
            
            wKeeperIMG.image = UIImage(data: Players.shared.getPlayerImage(name: DatabaseStorage.shared.getSelectedWicketKeepers()[0])!)
            wKeeperLBL.text = DatabaseStorage.shared.getSelectedWicketKeepers()[0]
        }
        
        
        navigationItem.title = "Your Team"
        // Do any additional setup after loading the view.
        
        
    }
    
    //get Your leagues whenever view appears
    override func viewWillAppear(_ animated: Bool) {
        // checkLeagueIsContain(teamID : 123456)
        getYourLeagues()
    }
    
    
    
    //Navigationg to MyLeague Table view controlller
    @IBAction func MyLeagues(_ sender: Any) {
        let MyLeagueTVC = self.storyboard?.instantiateViewController(identifier: "MyLeagueTableViewController") as! MyLeagueTableViewController
        MyLeagueTVC.leagues = self.myLeagues
        MyLeagueTVC.leagueref = leagueref
        self.navigationController?.pushViewController(MyLeagueTVC, animated: true)
    }
    
    
    //Generate random number to create a team
    @IBAction func createTeamToPlay(_ sender: Any) {
        
        var teamId :UInt32 = 0
        repeat{
            
            teamId = arc4random_uniform(999999)
        }while self.checkLeagueIsContain(teamID : teamId)
        showInputDialog(teamID : teamId)
        
    }
    
    
    
    @IBAction func joinTeamToPlay(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Your Team code", message: "", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            
            let teamCode = alertController.textFields?[0].text
            let yourName = alertController.textFields?[1].text
            
            let userID = Auth.auth().currentUser?.uid
            // self.myLeagues.append(teamID)
            
            
            
            //   if self.checkLeagueIsContain(teamID : UInt32(teamCode!)!) {
            
            self.leagueref?.child("leagues").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                self.leaguecount = value?.count ?? 0
                
                for i in 0..<self.leaguecount{
                    self.leagueref?.child("leagues/league\(i)").observeSingleEvent(of: .value, with: { (snapshot) in
                        let value = snapshot.value as? NSDictionary
                        let id =  value?["leagID"] as? UInt32 ?? 0
                        let name = value?["Team Name"] as? String ?? ""
                        
                        
                        if id == UInt32(teamCode!) {
                            
                            let lea = [
                                "leagID":  id,
                                "Team Name": name] as [String :Any]
                            self.myLeagues["league\(self.myleaguecount)"] = lea
                            
                            self.leagueref?.child("users/\(userID!)/MyLeagues").setValue(self.myLeagues , withCompletionBlock: {error, ref in
                                if error == nil {
                                    self.dismiss(animated: true, completion: nil)
                                }else{
                                    
                                }
                            })
                            
                            self.leagueref?.child("leagues/league\(i)/").observeSingleEvent(of: .value, with: { (snapshot) in
                                
                                let value = snapshot.value as? NSDictionary
                                var player = value?["players"] as? [String] ?? []
                                
                                player.append(yourName!)
                                for i in player{
                                    LeaguePlayers.shared.addLeaguePlayer(player: PlayersDetails(name: i))
                                    
                                }
                                
                                LeaguePlayers.shared.addLeaguePlayer(player: PlayersDetails(name: yourName!))
                                
                                /* var playerNames : [String] = []
                                 for i in LeaguePlayers.shared.playerNames(){
                                 playerNames.append(i.name)
                                 }*/
                                
                                let mat = [
                                    "leagID":  id,
                                    "Team Name": name ,
                                    "players" :player] as [String :Any]
                                
                                self.postleague["league\(i)"] = mat
                                
                                self.leagueref?.child("leagues").setValue( self.postleague, withCompletionBlock: {error, ref in
                                    if error == nil {
                                        
                                        self.dismiss(animated: true, completion: nil)
                                    }else{
                                        
                                    }
                                })
                            })
                            
                        }
                        
                    })
                }
                
                
            })
            // }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Team Code"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Your Preferred Name"
        }
        
        //adding the action to dialogbox
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
        
        
        let MyLeagueTVC = storyboard?.instantiateViewController(identifier: "MyLeagueTableViewController") as! MyLeagueTableViewController
        
        navigationController?.pushViewController(MyLeagueTVC, animated: true)
    }
    
    
    //Get Your Leagues
    func yourLeagues(teamID : UInt32, teamName :String, yourName :String){
        
        let userID = Auth.auth().currentUser?.uid
        let lea = [
            "leagID":  teamID,
            "Team Name": teamName] as [String :Any]
        self.myLeagues["league\(self.myleaguecount)"] = lea
        
        self.leagueref?.child("users/\(userID!)/MyLeagues").setValue(self.myLeagues , withCompletionBlock: {error, ref in
            if error == nil {
                
                self.dismiss(animated: true, completion: nil)
            }else{
                
            }
        })
        
        LeaguePlayers.shared.removePlayers()
        LeaguePlayers.shared.addLeaguePlayer(player: PlayersDetails(name: yourName))
        
        var playerNames : [String] = []
        for i in LeaguePlayers.shared.playerNames(){
            playerNames.append(i.name)
        }
        
        
        
        let mat = [
            "leagID":  teamID,
            "Team Name": teamName ,
            "players" :playerNames] as [String :Any]
        
        self.postleague["league\(self.getLeagueCount())"] = mat
        
        self.leagueref?.child("leagues").setValue( self.postleague, withCompletionBlock: {error, ref in
            if error == nil {
                
                self.dismiss(animated: true, completion: nil)
            }else{
                
            }
        })
        
    }
    
    
    //Alert Box for create team
    func showInputDialog(teamID : UInt32 ) {
        
        let alertController = UIAlertController(title: "Your Team code", message: "\(teamID)", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            
            //getting the input values from user
            let teamName = alertController.textFields?[0].text
            let yourName = alertController.textFields?[1].text
            
            
            // self.myLeagues.append(teamID)
            self.yourLeagues(teamID : teamID, teamName : teamName!, yourName : yourName!)
            
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Team Name"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Your Preferred Name"
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    func checkLeagueIsContain(teamID : UInt32) -> Bool {
        var check = false
        
        self.leagueref?.child("leagues").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.leaguecount = value?.count ?? 0
            
            for i in 0..<self.leaguecount{
                self.leagueref?.child("leagues/league\(i)").observeSingleEvent(of: .value, with: { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    let id =  value?["leagID"] as? UInt32 ?? 0
                    let name = value?["Team Name"] as? String ?? ""
                    let playerNames = value?["players"] as? [String] ?? []
                    
                    let mat = [
                        "leagID":  id,
                        "Team Name": name ,
                        "players" :playerNames] as [String :Any]
                    self.postleague["league\(i)"] = mat
                    
                    if id == teamID  {
                        check = true
                    }
                    
                })
            }
        })
        return check
    }
    
    
    func getLeagueCount() -> Int{
        self.leagueref?.child("leagues").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.leaguecount = value?.count ?? 0
            
            
        })
        
        return self.leaguecount
    }
    
    func getYourLeagues(){
        let userID = Auth.auth().currentUser?.uid
        self.leagueref?.child("users/\(userID!)/MyLeagues").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.myleaguecount = value?.count ?? 0
            
            
            for i in 0..<self.myleaguecount{
                let leag =  value?["league\(i)"] as? [String : Any] ?? [:]
                
                let lea = [
                    "leagID":  leag["leagID"],
                    "Team Name": leag["Team Name"],] as [String :Any]
                self.myLeagues["league\(i)"] = lea
                
            }
            
        })
    }
    
}



