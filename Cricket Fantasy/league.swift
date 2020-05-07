//
//  league.swift
//  Cricket Fantasy
//
//  Created by student on 4/11/20.
//  Copyright © 2020 student. All rights reserved.
//

import Foundation

//Struct for player details
struct PlayersDetails {
    var name : String
}

//The league players class for managing players in a league
class LeaguePlayers{
    
    private static var _shared : LeaguePlayers!
    
    static var shared:LeaguePlayers{
        if _shared == nil{
            _shared = LeaguePlayers()
        }
        return _shared
    }
    
    private var players :[PlayersDetails] = []
    
    private init(){
        
    }
    
    
    subscript(index:Int) -> PlayersDetails? {
        return index >= 0 && index < players.count ? players[index] : nil
    }
    
    
    //Returns Number of players in that league
    func numPlayers() -> Int{
        return players.count
    }
    
    //Add a player into that league
    func addLeaguePlayer(player : PlayersDetails){
        players.append(player)
    }
    
    //Remove all players
    func removePlayers(){
        players.removeAll()
    }
    
    // Return all player names
    func playerNames() ->[PlayersDetails]{
        return players
    }
    
}
