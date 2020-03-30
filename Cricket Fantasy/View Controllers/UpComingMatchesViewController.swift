//
//  UpComingMatchesViewController.swift
//  Cricket Fantasy
//
//  Created by student on 3/5/20.
//  Copyright © 2020 student. All rights reserved.
//

import UIKit

class UpComingMatchesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJSON{
            self.tableView.reloadData()
        }
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    var matches = [Tournament]()
    
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(matches.count)
        return matches.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = matches[indexPath.row].team1
            return cell
        
       }
       
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playersVC = storyboard?.instantiateViewController(identifier: "VC") as! ViewController
       navigationController?.pushViewController(playersVC, animated: true)
        
    }

    

    
    func downloadJSON(completed: @escaping ()->()){
     
        let url  = URL(string: "https://cricapi.com/api/matches?apikey=Jfyu91sxtCMeQvnsXPkDrCqpS6x1")
         
        URLSession.shared.dataTask(with: url!){(data, response, error) in
            
            if error == nil{
                do{
                    print("fugj")
                    let match = try JSONDecoder().decode(ComingMatch.self, from: data!)
                    self.matches = match.matches
                    
                    DispatchQueue.main.async {
                        completed()
                        
                    }
                }catch{
                    print("JSON Error")
                }
            }else{
              
            }
        }.resume()
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
