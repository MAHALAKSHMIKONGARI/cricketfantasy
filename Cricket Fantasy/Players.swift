//
//  Players.swift
//  Cricket Fantasy
//
//  Created by student on 3/26/20.
//  Copyright © 2020 student. All rights reserved.
//

import Foundation

struct PlayerSquad : Decodable{
    
    var squad : [Squads]
    var v : String
}

struct Squads :Decodable{
    var players : [player]
    var name : String
}

struct player : Decodable{
    var pid: Int
    var name : String
}

struct PlayerStatistics : Decodable{
    var imageURL :String
    var playingRole : String
}

//This class is responsible for sorting players as per their roles
class Players{
    
    private static var _shared : Players!
    
    static var shared:Players{
        if _shared == nil{
            _shared = Players()
        }
        return _shared
    }
    
    private var players : [player] = []
    private var bowler : [String] = []
    private var batsman : [String] = []
    private var wKeeper : [String] = []
    private var allRounder :[String] = []
    private var playerImage : [String :String] = [:]
    
    
    subscript(index:Int) -> player? {
        return index >= 0 && index < players.count ? players[index] : nil
    }
    
    // Returns bowler count for corresponding Match
    func getNumBowlers() -> Int{
        return bowler.count
    }
    
    // Returns batsman count for corresponding Match
    func getNumBatsmans() -> Int{
        return batsman.count
    }
    
    // Returns Wicket Keeper count for corresponding Match
    func getNumWicketKeepers() -> Int{
        return wKeeper.count
    }
    
    // Returns All Rounder count for corresponding Match
    func getNumallRounders() -> Int{
        return allRounder.count
    }
    
    // Return all Bowlers
    func getBowlers() ->[String]{
        return bowler
    }
    
    // Return all batsman
    func getBatsmans() ->[String]{
        return batsman
    }
    
    // Return all Wicket Keepers
    func getWicketKeepers() ->[String]{
        return wKeeper
    }
    
    // Return All Rounders
    func getAllRounders() ->[String]{
        return allRounder
    }
    
    //Add bowler to bowler array
    func addBowler(bowlerName:String){
        bowler.append(bowlerName)
    }
    
    //Add batsman to batsman array
    func addBatsmans(batsmanName:String){
        batsman.append(batsmanName)
    }
    
    //Add Wicket keeper
    func addWicketKeeper(wKeeperName:String){
        wKeeper.append(wKeeperName)
    }
    
    //Add All Rounder
    func addAllRounder(allRounderName:String){
        allRounder.append(allRounderName)
    }
    
    func getImageUrl(name : String) -> String?{
        return playerImage[name]
    }
    
    func getPlayerImage(name : String) -> Data? {
        
        let url = URL(string: getImageUrl(name: name)!)
        let data = try? Data(contentsOf: url!)
        return data
    }
    
    
    
    func resetPlayers(){
        bowler  = []
        batsman = []
        wKeeper = []
        allRounder  = []
    }
    
    
    private init(){
        resetPlayers()
    }
    
    //Fetch players from CricAPi corresponding to that matchID and append the players
    func fetchPlayers(matchID : Int){
        
        //  DispatchQueue.main.async {
        
        if let url  = URL(string:   "https://cricapi.com/api/fantasySquad?apikey=Jfyu91sxtCMeQvnsXPkDrCqpS6x1&unique_id=\(matchID)"){
            
            //URLSession.shared.dataTask(with: url){(data, response, error) in
            
            
            do{
                let contents = try String(contentsOf: url)
                let data = try Data(contentsOf : url)
                let playerSquad = try JSONDecoder().decode(PlayerSquad.self, from: data)
                
                self.players = playerSquad.squad[0].players
                
                for i in 0..<playerSquad.squad[1].players.count{
                    self.players.append(playerSquad.squad[1].players[i])
                }
                
                for i in 0..<self.players.count{
                    self.playerstats(playerId : self.players[i].pid, index: i)
                }
                
            }catch{
                print("JSON Error")
            }
        }
        
        // }
    }
    
    
    //segregate the players based the role
    func playerstats(playerId : Int, index : Int){
        //  DispatchQueue.main.async {
        let url  = URL(string: "https://cricapi.com/api/playerStats?apikey=Jfyu91sxtCMeQvnsXPkDrCqpS6x1&pid=\(playerId)")
        
        URLSession.shared.dataTask(with: url!){(data, response, error) in
            
            if error == nil{
                do{
                    let playerstats = try JSONDecoder().decode(PlayerStatistics.self, from: data!)
                    
                    self.playerImage[self.players[index].name] = playerstats.imageURL
                    
                    if playerstats.playingRole.contains("Bowler"){
                        self.bowler.append(self.players[index].name)
                        
                    }
                    else if playerstats.playingRole.contains("batsman"){
                        self.batsman.append(self.players[index].name)
                    }
                    
                    if playerstats.playingRole.contains("Wicketkeeper"){
                        self.wKeeper.append(self.players[index].name)
                    }
                    else if playerstats.playingRole.contains("Allrounder"){
                        self.allRounder.append(self.players[index].name)
                    }
                    
                    NotificationCenter.default.post(name: NSNotification.Name("player added"), object: nil)
                    
                }catch{
                    print("JSON Error")
                    
                }
            }else{
                
            }
            
        }.resume()
        //  }
        
    }
    
    
}
