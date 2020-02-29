//
//  SelectPlayersViewController.swift
//  Cricket Fantasy
//
//  Created by student on 2/25/20.
//  Copyright © 2020 student. All rights reserved.
//

import UIKit

class SelectPlayersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var match : Match!
    
    @IBOutlet weak var country1IV: UIImageView!
    
    @IBOutlet weak var country2IV: UIImageView!
    
    
    @IBOutlet weak var country1LBL: UILabel!
    
  
    @IBOutlet weak var country2LBL: UILabel!
    
    
    @IBOutlet weak var tableView:UITableView!
   
  
    
    var country1 = ""
    var country2 = ""
    var country1Img = UIImage()
    var country2Img = UIImage()
    
    var nameLBLTag = 10
    var creditLBLTag = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
               backgroundImage.image = UIImage(named: "background.jpg")
               backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
               self.view.insertSubview(backgroundImage, at: 0)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logout))
        
        country1LBL.text = country1
        country2LBL.text = country2
        country1IV.image = country1Img
        country2IV.image = country2Img
        // Do any additional setup after loading the view.
    }
    
    @objc func logout(){
        let logout = storyboard?.instantiateViewController(identifier: "VC") as! ViewController
        
        navigationController?.pushViewController(logout, animated: true)
        
    }
    
    let optimalRowHeight:CGFloat = 60
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return optimalRowHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return match.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
            let cell = tableView.dequeueReusableCell(withIdentifier: "players", for: indexPath)
            let player = match.players[indexPath.row]
     
            let nameLBL = cell.viewWithTag(nameLBLTag) as! UILabel
            let creditLBL  = cell.viewWithTag(creditLBLTag) as! UILabel
            
            nameLBL.text = player.name
            creditLBL.text = "\(player.credit)"

         return cell
        

    }
    
    
    @IBAction func Bowler(_ sender: Any) {
        
        
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
