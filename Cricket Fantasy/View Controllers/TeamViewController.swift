//
//  TeamViewController.swift
//  Cricket Fantasy
//
//  Created by student on 3/17/20.
//  Copyright © 2020 student. All rights reserved.
//

import UIKit

class TeamViewController: UIViewController {

    
    @IBOutlet weak var bowler1LBL: UILabel!
    @IBOutlet weak var bowler2LBL: UILabel!
    @IBOutlet weak var bowler3LBL: UILabel!
    @IBOutlet weak var bowler4LBL: UILabel!
    
    @IBOutlet weak var batsman1LBL: UILabel!
    @IBOutlet weak var batsman2LBL: UILabel!
    @IBOutlet weak var batsman3LBL: UILabel!
    @IBOutlet weak var batsman4LBL: UILabel!
    
    @IBOutlet weak var allRounder1LBL: UILabel!
    @IBOutlet weak var allRounder2LBL: UILabel!
    @IBOutlet weak var wKeeperLBL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if DatabaseStorage.shared.getBowlerCount() == 0 {
            bowler1LBL.text = "Not selected"
            bowler2LBL.text = "Not selected"
            bowler3LBL.text = "Not selected"
            bowler4LBL.text = "Not selected"
        }
        else{
            bowler1LBL.text = DatabaseStorage.shared.getSelectedBowlers()[0]
            bowler2LBL.text = DatabaseStorage.shared.getSelectedBowlers()[1]
            bowler3LBL.text = DatabaseStorage.shared.getSelectedBowlers()[2]
            bowler4LBL.text = DatabaseStorage.shared.getSelectedBowlers()[3]
        }
        
        if DatabaseStorage.shared.getBatsmanCount() == 0{
            batsman1LBL.text = "Not selected"
            batsman2LBL.text = "Not selected"
            batsman3LBL.text = "Not selected"
            batsman4LBL.text = "Not selected"
        }
        else{
            batsman1LBL.text = DatabaseStorage.shared.getSelectedBatsmans()[0]
            batsman2LBL.text = DatabaseStorage.shared.getSelectedBatsmans()[1]
            batsman3LBL.text = DatabaseStorage.shared.getSelectedBatsmans()[2]
            batsman4LBL.text = DatabaseStorage.shared.getSelectedBatsmans()[3]
        }
        
        if DatabaseStorage.shared.getAllRounderCount() == 0{
            
             allRounder1LBL.text = "Not selected"
             allRounder2LBL.text = "Not selected"
        }
        else{
            allRounder1LBL.text = DatabaseStorage.shared.getSelectedAllRounders()[0]
            allRounder2LBL.text = DatabaseStorage.shared.getSelectedAllRounders()[1]
        }
        
        
        if DatabaseStorage.shared.getWicketKeeperCount() == 0 {
             wKeeperLBL.text = "Not selected"
        }
        else{
            wKeeperLBL.text = DatabaseStorage.shared.getSelectedWicketKeepers()[0]
        }
        
        
        navigationItem.title = "Your Team"
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "logout", style: .done, target: self, action: #selector(logout))
    }
    
    
    @objc func logout(){
        
        let next = storyboard?.instantiateViewController(identifier: "VC") as! ViewController
        navigationController?.pushViewController(next, animated: true)
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
