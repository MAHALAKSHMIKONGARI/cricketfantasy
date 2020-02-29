//
//  Matches.swift
//  Cricket Fantasy
//
//  Created by student on 2/25/20.
//  Copyright © 2020 student. All rights reserved.
//

import Foundation


struct Player{
    var name : String
    var credit: Double
}

struct Match {
    
    var country1: String
    var country2:String
    var players : [Player]
}

/// A collection of fine dining establishments, aka Restaurants
class Matches {
    
    private static var _shared:Matches! // Only visible in this struct
    
    static var shared:Matches {         // To access this anywhere, in the app just write Restaurants.shared
        if _shared == nil {
            _shared = Matches()
        }
        return _shared
    }
    
    private var matches:[Match] = [ Match(country1: "India", country2: "NewZland", players :[Player(name:"kohli", credit: 9.0)
        , Player(name: "Dhoni", credit: 8.5)
        , Player(name: "Umesh Yadv", credit: 7.5)
        , Player(name: "Taylor", credit: 9.0)
        , Player(name: "Williamson", credit: 9.0)
        , Player(name: "Rohith Sharma", credit: 9.0)
        , Player(name: "Boult", credit: 8.5)
        , Player(name: "Sachin Tendulkar", credit: 9.0)
        ,Player(name: "Henry Nicholos", credit: 8.0)
        , Player(name: "Southee", credit: 9.0)
        ,Player(name: "Jadeja", credit: 8.5)
        ,Player(name: "Ashwin", credit: 8.0)
        ,Player(name: "Bumrah", credit: 8.0)
        ,Player(name: "Ajaz patel", credit: 8.5)
        , Player(name:"Latham", credit: 7.5)
        , Player(name: "Rahane", credit: 8.5)
        , Player(name: "Pant", credit: 7.5)]),
                                    
                                    
    Match(country1: "Srilanka", country2: "WestIndies", players :[
        Player(name: "Lasit Malinga", credit: 8.5)
        , Player(name: "Dinesh Chandimal", credit:7.5 )
        ,Player(name: "Shai hope", credit: 8.0)
        , Player(name: "Pooran", credit: 8.5)
        ,Player(name: "Cottrell", credit: 8.5)
        , Player(name: "Mendis", credit: 8.5)
        ,Player(name: "Perera", credit: 9.0)
        ,Player(name: "Udana", credit: 9.0)
        ,Player(name:"Holder",credit: 7.5)]),
                                             
        
    ]
    
    private init(){                         // We can't make another Restaurants instance, which is a Good Thing: we only want 1 model
    }
    
    
    /// Returns restaurant at a given index, nil if non-existant
    /// Example usage:  Restaurants.shared.getRestaurant(at:5)
    /// - Parameter index: restaurant to return
    
    func getMatch(at index:Int)->Match? {
        if index >= 0 && index < matches.count {
            return matches[index]
        } else {
            return nil
        }
    }
    
    /// Returns the number of Restaurants
    func numMatches()->Int{
        return matches.count
    }
    
    // Alternatively, we could subscript Restaurants, so usage would be Restaurants.shared[5]
    
    subscript(index:Int) -> Match? {
        return index >= 0 && index < matches.count ? matches[index] : nil
    }
    
    /// Adds a restaurant to the collection
    /// Example usage: Restaurants.shared.add(restaurant:Restaurant(name:"A & G", rating:4))
    /// - Parameter restaurant: restaurant to add
    
    func add(restaurant:Match){
        matches.append(restaurant)
    }
    
    //Now we can delete restaurants too..
    func delete(at:Int){
        matches.remove(at: at)
    }
    
}
