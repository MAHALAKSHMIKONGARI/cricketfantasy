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
    
    
    
    func NumberofMatchesInDatabase (ref: DatabaseReference?, userid: String, matchID: Int, completion: (Bool) -> ()){
        var matched = false
        ref?.child("users/\(userid)/Matches").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            SelectPlayersViewController.matchnum = value?.count ?? 0
            //print(self.matchnum)
            
            for i in 0..<SelectPlayersViewController.matchnum{                ref?.child("users/\(userid)/Matches/match\(i)").observeSingleEvent(of: .value, with: { (snapshot) in
                    // Get user value
                    let value = snapshot.value as? NSDictionary
                    // self.matchnum = value!.count
                    let id =  value?["matchID"] as? Int ?? 0
                print(SelectPlayersViewController.storedmatches)
               if !SelectPlayersViewController.storedmatches.contains(id){
                   SelectPlayersViewController.storedmatches.append(id)
                }
                 print(SelectPlayersViewController.storedmatches)
                    print(id)
                    print(matchID)
                 print( SelectPlayersViewController.postObj)
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
                            
                        }) { (error) in
                            print(error.localizedDescription)
                            
                        }
                    }
                    else{
                        
                       
                    }
                    print( SelectPlayersViewController.postObj)
                    
                }) { (error) in
                    print(error.localizedDescription)
                }
                
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
        if matched ==  false{
                   print("matcged")
                   allroundercount = 0
                   wicketkeepercount = 0
                   batsmancount = 0
                   bowlercount = 0
                   
                  print( selectedbowlers.removeAll())
                   selectedbatsman.removeAll()
                   selectedWkeeper.removeAll()
                   selectedallRounder.removeAll()
                   
        
        }
    }
    
    
    func getBowlerCount()->Int{
        return bowlercount
    }
    
    func getBatsmanCount() -> Int{
        return batsmancount
    }
    
    func getWicketKeeperCount() -> Int{
        return wicketkeepercount
    }
    
    func getAllRounderCount() -> Int{
        return allroundercount
    }
    
    func getSelectedBowlers() ->[String]{
        return selectedbowlers
    }
    
    func getSelectedBatsmans() ->[String]{
           return selectedbatsman
    }
       
    func getSelectedWicketKeepers() ->[String]{
           return selectedWkeeper
    }
       
    func getSelectedAllRounders() ->[String]{
           return selectedallRounder
       }
    
    
    func deleteBowler(at:Int){
        selectedbowlers.remove(at: at)
    }
    
    func deleteBatsman(at:Int){
        selectedbatsman.remove(at: at)
    }
    
    func deleteWicketKeeper(at:Int){
        selectedWkeeper.remove(at: at)
    }
    
    func deleteAllRounder(at:Int){
        selectedallRounder.remove(at: at)
    }
    
    func addSelectedBowler(bowlerName:String){
        selectedbowlers.append(bowlerName)
    }
    
    func addSelectedBatsmans(batsmanName:String){
        selectedbatsman.append(batsmanName)
    }
    
    func addSelectedWicketKeeper(wKeeperName:String){
        selectedWkeeper.append(wKeeperName)
    }
    func addSelectedAllRounder(allRounderName:String){
        selectedallRounder.append(allRounderName)
    }
    
    func incrementBowlerCount(){
        bowlercount += 1
    }
    
    func incrementBatsmanCount(){
        batsmancount += 1
    }
    
    func incrementWKeeperCount(){
        wicketkeepercount += 1
    }
    
    func incrementAllRounderCount(){
        allroundercount += 1
    }
    
    func decrementBowlerCount(){
        bowlercount -= 1
    }
    
    func decrementBatsmanCount(){
        batsmancount -= 1
    }
    
    func decrementWkeeperCount(){
        wicketkeepercount -= 1
    }
    
    func decrementAllRounderCount(){
        allroundercount -= 1
    }
    
    
    
}


