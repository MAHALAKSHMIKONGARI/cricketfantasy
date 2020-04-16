//
//  league.swift
//  Cricket Fantasy
//
//  Created by student on 4/11/20.
//  Copyright © 2020 student. All rights reserved.
//

import Foundation


struct PlayersDetails {
    var name : String
}

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
    
    func numPlayers() -> Int{
        return players.count
    }
    
    func addLeaguePlayer(player : PlayersDetails){
        players.append(player)
    }
    
    func removePlayers(){
        players.removeAll()
    }
    
    func playerNames() ->[PlayersDetails]{
        return players
    }
    
}
