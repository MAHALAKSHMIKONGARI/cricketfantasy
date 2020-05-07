//
//  DatabaseStorage.swift
//  Cricket Fantasy
//
//  Created by student on 3/28/20.
//  Copyright © 2020 student. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

//Class to handle the Database of the application
class DatabaseStorage{
    
    
    
    private static var _shared:DatabaseStorage!
    
    static var shared:DatabaseStorage{
        if _shared == nil{
            _shared = DatabaseStorage()
        }
        return _shared
    }
    
    private var selectedbowlers :[String] = []
    private var selectedbatsman :[String] = []
    private var selectedWkeeper :[String] = []
    private var selectedallRounder :[String] = []
    private var bowlercount = 0
    private var batsmancount = 0
    private var allroundercount = 0
    private var wicketkeepercount = 0
    
    
    
    // Fetch all the matches that are stored in database for corresponding user
    func FectchMatchData(ref: DatabaseReference?, userid: String){
        
        ref?.child("users/\(userid)/Matches").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let count = value?.count ?? 0
            
            for i in 0..<count{
                let match =  value?["match\(i)"] as? [String : Any] ?? [:]
                SelectPlayersViewController.postObj["match\(i)"] = match
            }
            
        })
    }
    
    
    // If players are alreay seclected for this match then read players and count otherwise reset the players array and count
    func NumberofMatchesInDatabase (ref: DatabaseReference?, userid: String, matchID: Int){
        
        var matched = false
        ref?.child("users/\(userid)/Matches").observeSingleEvent(of: .value, with: { (snapshot) in
            
            // Get user value
            let value = snapshot.value as? NSDictionary
            // Number of matches for corresponding user
            SelectPlayersViewController.matchnum = value?.count ?? 0
            
            for i in 0..<SelectPlayersViewController.matchnum{
                
                ref?.child("users/\(userid)/Matches/match\(i)").observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    // get match id
                    let value = snapshot.value as? NSDictionary
                    let id =  value?["matchID"] as? Int ?? 0
                    
                    if !SelectPlayersViewController.storedmatches.contains(id){
                        SelectPlayersViewController.storedmatches.append(id)
                    }
                    
                    // If players are alreay seclected for this match then read players and count
                    if id == matchID{
                        ref?.child("users/\(userid)/Matches/match\(i)/players").observeSingleEvent(of: .value, with: { (snapshot) in
                            
                            let value = snapshot.value as? NSDictionary
                            self.bowlercount = value?["bowlerscount"] as? Int ?? 0
                            self.selectedbowlers = value?["bowler"] as? [String] ?? []
                            
                            self.batsmancount = value?["batsmancount"] as? Int ?? 0
                            self.selectedbatsman = value?["batsman"] as? [String] ?? []
                            
                            self.wicketkeepercount = value?["WKcount"] as? Int ?? 0
                            self.selectedWkeeper = value?["wiketkeeper"] as? [String] ?? []
                            
                            self.allroundercount = value?["ALLRoundercount"] as? Int ?? 0
                            self.selectedallRounder = value?["allrounder"] as? [String] ?? []
                            
                            matched =  true
                            
                        })
                    }
                })
            }
        })
        
        // If players are not selected for this match then reset the players array and count
        if matched ==  false{
            allroundercount = 0
            wicketkeepercount = 0
            batsmancount = 0
            bowlercount = 0
            
            selectedbowlers.removeAll()
            selectedbatsman.removeAll()
            selectedWkeeper.removeAll()
            selectedallRounder.removeAll()
            
        }
    }
    
    
    // Returns number of bowlers selected for corresponding match
    func getBowlerCount()->Int{
        return bowlercount
    }
    
    // Returns number of batsmans selected for corresponding match
    func getBatsmanCount() -> Int{
        return batsmancount
    }
    
    // Returns number of Wicket Keepers selected for corresponding match
    func getWicketKeeperCount() -> Int{
        return wicketkeepercount
    }
    
    // Returns number of All rounders selected for corresponding match
    func getAllRounderCount() -> Int{
        return allroundercount
    }
    
    // Returns bowlers selected for corresponding match
    func getSelectedBowlers() ->[String]{
        return selectedbowlers
    }
    
    // Returns batsmans selected for corresponding match
    func getSelectedBatsmans() ->[String]{
        return selectedbatsman
    }
    
    // Returns Wicket Keepers selected for corresponding match
    func getSelectedWicketKeepers() ->[String]{
        return selectedWkeeper
    }
    
    // Returns All rounders selected for corresponding match
    func getSelectedAllRounders() ->[String]{
        return selectedallRounder
    }
    
    //Delete Bowler
    func deleteBowler(at:Int){
        selectedbowlers.remove(at: at)
    }
    
    //Delete Batsman
    func deleteBatsman(at:Int){
        selectedbatsman.remove(at: at)
    }
    
    //Delete Wicket Keeper
    func deleteWicketKeeper(at:Int){
        selectedWkeeper.remove(at: at)
    }
    
    //Delete All Rounder
    func deleteAllRounder(at:Int){
        selectedallRounder.remove(at: at)
    }
    
    //Add bowler to selected bowlers array
    func addSelectedBowler(bowlerName:String){
        selectedbowlers.append(bowlerName)
    }
    
    //Add batsman to selected batsman array
    func addSelectedBatsmans(batsmanName:String){
        selectedbatsman.append(batsmanName)
    }
    
    //Add Wicket Keeper to selected Wicket keeper array
    func addSelectedWicketKeeper(wKeeperName:String){
        selectedWkeeper.append(wKeeperName)
    }
    
    //Add All rounder to selected all rounder array
    func addSelectedAllRounder(allRounderName:String){
        selectedallRounder.append(allRounderName)
    }
    
    // Increment the Bowler Count
    func incrementBowlerCount(){
        bowlercount += 1
    }
    
    // Increment the Batsman Count
    func incrementBatsmanCount(){
        batsmancount += 1
    }
    
    // Increment the wicket keepers count
    func incrementWKeeperCount(){
        wicketkeepercount += 1
    }
    
    // Increment the all Rounder count
    func incrementAllRounderCount(){
        allroundercount += 1
    }
    
    // Decrement the Bowler Count
    func decrementBowlerCount(){
        bowlercount -= 1
    }
    
    // Decrement the Batsman Count
    func decrementBatsmanCount(){
        batsmancount -= 1
    }
    
    // Decrement the Wicket Keeper Count
    func decrementWkeeperCount(){
        wicketkeepercount -= 1
    }
    
    // Decrement the All Rounder Count
    func decrementAllRounderCount(){
        allroundercount -= 1
    }
    
    
    
}


