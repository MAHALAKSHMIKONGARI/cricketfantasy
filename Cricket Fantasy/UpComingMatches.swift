//
//  UpComingMatches.swift
//  Cricket Fantasy
//
//  Created by student on 3/4/20.
//  Copyright © 2020 student. All rights reserved.
//

import Foundation


struct ComingMatch : Codable{
    
    var matches : [Tournament]
    
}

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





class Tournaments{
    private static var _shared:Tournaments!
    
    static var shared:Tournaments {         // To access this anywhere, in the app just write Restaurants.shared
        if _shared == nil {
            _shared = Tournaments()
        }
        return _shared
    }
    
    private var comingmatches : [Tournament] = []
    
    
    
    subscript(index:Int) -> Tournament? {
        return index >= 0 && index < comingmatches.count ? comingmatches[index] : nil
    }
    
    func numMatches()->Int{
        return comingmatches.count
    }
    
    func fetchMatch(completed: @escaping ()->()){
        let url  = URL(string: "https://cricapi.com/api/matches?apikey=Jfyu91sxtCMeQvnsXPkDrCqpS6x1")
        
        URLSession.shared.dataTask(with: url!){(data, response, error) in
            
            if error == nil{
                do{
                    
                    let match = try JSONDecoder().decode(ComingMatch.self, from: data!)
                    for i in 0..<match.matches.count{
                        // if match.matches[i].type == "Twenty20" && match.matches[i].type == "ODI" {
                        
                        self.comingmatches.append(match.matches[i])
                        // }
                    }
                    DispatchQueue.main.async {
                                           completed()
                                           
                       }
                   // NotificationCenter.default.post(name: NSNotification.Name("Match added"), object: nil)
                    
                }catch{
                    print("JSON Error")
                }
            }else{
                
            }
        }.resume()
        
    }
    
    private init(){
      //  fetchMatch()
    }
}
