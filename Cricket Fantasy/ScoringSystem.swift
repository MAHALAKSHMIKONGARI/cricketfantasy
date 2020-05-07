//
//  ScoringSystem.swift
//  Cricket Fantasy
//
//  Created by student on 5/6/20.
//  Copyright © 2020 student. All rights reserved.
//

import Foundation


struct ScoringSystem{
    var scoreItem : String
    var points : Double
}

//This class is for the view of scoring system view in the side menu bar.
class ScorePoints {
    
    private static var _shared : ScorePoints!
    
    static var shared:ScorePoints{
        if _shared == nil{
            _shared = ScorePoints()
        }
        return _shared
    }
    
    private var points : [ScoringSystem] = [ScoringSystem(scoreItem: "Run", points: 0.50),
                                            ScoringSystem(scoreItem: "Four", points: 0.50),
                                            ScoringSystem(scoreItem: "Six", points: 1.00),
                                            ScoringSystem(scoreItem: "Half Century", points: 4.00),
                                            ScoringSystem(scoreItem: "Century", points: 8.00),
                                            ScoringSystem(scoreItem: "Duck out", points: -2.00),
                                            ScoringSystem(scoreItem: "Wicket", points: 10.00),
                                            ScoringSystem(scoreItem: "Four Wicket", points: 4.00),
                                            ScoringSystem(scoreItem: "Five Wicket", points: 8.00),
                                            ScoringSystem(scoreItem: "Maiden Over", points: 4.00),
                                            ScoringSystem(scoreItem: "Catch", points: 4.00),
                                            ScoringSystem(scoreItem: "Stumping", points: 6.00),
                                            ScoringSystem(scoreItem: "Run Out", points: 4.00),
                                            ScoringSystem(scoreItem: "Minimum Overs Bowled", points: 2.00),
                                            ScoringSystem(scoreItem: "Below 4", points: 3.00),
                                            ScoringSystem(scoreItem: "Between 4 to 5", points: 2.00),
                                            ScoringSystem(scoreItem: "Between 5 to 6", points: 1.00),
                                            ScoringSystem(scoreItem: "Between 9 to 10", points: -1.00),
                                            ScoringSystem(scoreItem: "Between 10 to 11", points: -2.00),
                                            ScoringSystem(scoreItem: "Above 11", points: -3.00),
                                            ScoringSystem(scoreItem: "Minimum Balls Faced", points: 10.00),
                                            ScoringSystem(scoreItem: "Between 60 to 70", points: -1.00),
                                            ScoringSystem(scoreItem: "Between 50 to 60", points: -2.00),
                                            ScoringSystem(scoreItem: "Below 50", points: -3.00),
    ]
    
    
    
    
    subscript(index:Int) -> ScoringSystem? {
        return index >= 0 && index < points.count ? points[index] : nil
    }
    
    
    //Return Number of Score Items
    func NumScoreItems() -> Int{
        return points.count
    }
    
    
    private init(){
        
    }
    
    
}
