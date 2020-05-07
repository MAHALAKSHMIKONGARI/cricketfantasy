//
//  UpComingMatches.swift
//  Cricket Fantasy
//
//  Created by student on 3/4/20.
//  Copyright © 2020 student. All rights reserved.
//

import Foundation


//Json structure in Cric Api for upcoming matches

struct ComingMatch : Codable{
    
    var matches : [Tournament]
    
}

//Struct for handling JSON data from the api
struct Tournament: Codable {
    var dateTimeGMT : String
    var unique_id : Int
    var matchStarted : Bool
    var team1 : String
    var team2 : String
    var type : String
    
    private enum CodingKeys:String, CodingKey{
        
        case dateTimeGMT
        case unique_id
        case matchStarted
        case team1 = "team-1"
        case team2 = "team-2"
        case type 
        
    }
}

//Class to handle tournaments
class Tournaments{
    private static var _shared:Tournaments!
    
    static var shared:Tournaments {         // To access this anywhere, in the app just write Tournaments.shared
        if _shared == nil {
            _shared = Tournaments()
        }
        return _shared
    }
    
    private var comingmatches : [Tournament] = []
    
    
    // Returns tournament for corresponding index
    subscript(index:Int) -> Tournament? {
        return index >= 0 && index < comingmatches.count ? comingmatches[index] : nil
    }
    
    
    //returns count of upcoming matches
    func numMatches()->Int{
        return comingmatches.count
    }
    
    
    //Fetch Twenty20 matches
    func fetchMatch(){
        
        // URL for upcoming matches
        let url  = URL(string: "https://cricapi.com/api/matches?apikey=Jfyu91sxtCMeQvnsXPkDrCqpS6x1")
        
        URLSession.shared.dataTask(with: url!){(data, response, error) in
            
            if error == nil{
                do{
                    // match will have all the match details.
                    let match = try JSONDecoder().decode(ComingMatch.self, from: data!)
                    
                    // Storing Twenty20 matches to comingmatches
                    for i in 0..<match.matches.count{
                        if match.matches[i].type == "Twenty20" {
                            
                            self.comingmatches.append(match.matches[i])
                            
                            //sending notification to HomeTableViewController that match is added
                            NotificationCenter.default.post(name: NSNotification.Name("Match added"), object: nil)
                        }
                    }
                    
                    
                }catch{
                    print("JSON Error")
                }
            }else{
                
            }
        }.resume()
        
    }
    
    
    private init(){
        fetchMatch()
    }
    
}
