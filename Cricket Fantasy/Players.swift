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
    var playingRole : String
}


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
    
    subscript(index:Int) -> player? {
        return index >= 0 && index < players.count ? players[index] : nil
    }
    
    func getNumBowlers() -> Int{
        return bowler.count
    }
    
    func getNumBatsmans() -> Int{
        return batsman.count
    }
    
    func getNumWicketKeepers() -> Int{
        return wKeeper.count
    }
    
    func getNumallRounders() -> Int{
        return allRounder.count
    }
    
    func getBowlers() ->[String]{
        return bowler
    }
    
    func getBatsmans() ->[String]{
        return batsman
    }
    
    func getWicketKeepers() ->[String]{
        return wKeeper
    }
    
    func getAllRounders() ->[String]{
        return allRounder
    }
    
    func addBowler(bowlerName:String){
        bowler.append(bowlerName)
    }
    
    func addBatsmans(batsmanName:String){
        batsman.append(batsmanName)
    }
    
    func addWicketKeeper(wKeeperName:String){
        wKeeper.append(wKeeperName)
    }
    func addAllRounder(allRounderName:String){
        allRounder.append(allRounderName)
    }
    
    func deleteBowler(at:Int){
        bowler.remove(at: at)
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
    
    func fetchPlayers(matchID : Int){
        
      //  DispatchQueue.main.async {
    
        if let url  = URL(string:   "https://cricapi.com/api/fantasySquad?apikey=Jfyu91sxtCMeQvnsXPkDrCqpS6x1&unique_id=\(matchID)"){
         
        //URLSession.shared.dataTask(with: url){(data, response, error) in
            
           
                do{
                    let contents = try String(contentsOf: url)
                    print(contents)
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
    
    
    
    func playerstats(playerId : Int, index : Int){
       //  DispatchQueue.main.async {
        let url  = URL(string: "https://cricapi.com/api/playerStats?apikey=Jfyu91sxtCMeQvnsXPkDrCqpS6x1&pid=\(playerId)")
         
        URLSession.shared.dataTask(with: url!){(data, response, error) in
            
            if error == nil{
                do{
                    let playerstats = try JSONDecoder().decode(PlayerStatistics.self, from: data!)
                    
                    print(playerstats)
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
