//
//  HomeViewController.swift
//  Cricket Fantasy
//
//  Created by student on 2/19/20.
//  Copyright © 2020 student. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var tableView:UITableView!
    

    private static var _shared: HomeViewController! // Only visible in this struct
    
    static var shared:HomeViewController {         // To access this anywhere, in the app just write Restaurants.shared
        if _shared == nil {
            _shared = HomeViewController()
        }
        return _shared
    }
    
    let cellIdentifier = "MealTableViewCell"
    
   var matches:[String]=["India", "Srilanka"]
    var matches1:[String] = ["NewZland", "WestIndies"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background.jpg")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 120
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
             
                 return matches.count
                     
             }
             
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                 
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath) as? MatchesTableViewCell//returns an optional
           cell?.country1LBL.text = matches[indexPath.row] //textLabel is optional. So, we have to unwrap it
            cell?.country1IMG.image = UIImage(named: matches[indexPath.row])
           
           cell?.country2LBL.text = matches[indexPath.row] //textLabel is optional. So, we have to unwrap it
           cell?.country2IMG.image = UIImage(named: matches1[indexPath.row])
        
       
        print("in")
         
           return cell!
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
