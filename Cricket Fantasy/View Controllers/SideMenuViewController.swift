//
//  SideMenuViewController.swift
//  Cricket Fantasy
//
//  Created by student on 4/29/20.
//  Copyright © 2020 student. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    //Navigate to Scoring System Table view Controller
    @IBAction func ScoringSystem(_ sender: Any) {
        
        let scoreSystem = storyboard?.instantiateViewController(identifier: "SSTVC") as! ScoreSystemTableViewController
        navigationController?.pushViewController(scoreSystem, animated: true)
        
    }
    
    //Navvigating to Contact us View Controller
    @IBAction func ContactUs(_ sender: Any) {
        let contactUs = storyboard?.instantiateViewController(identifier: "CUVC") as! ContactUsViewController
        navigationController?.pushViewController(contactUs, animated: true)
    }
    
    //Navigationg to View Controller
    @IBAction func LogOut(_ sender: Any) {
        let logOut = storyboard?.instantiateViewController(identifier: "VC") as! ViewController
        navigationController?.pushViewController(logOut, animated: true)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
