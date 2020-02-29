//
//  LoginViewController.swift
//  Cricket Fantasy
//
//  Created by student on 2/19/20.
//  Copyright © 2020 student. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background.jpg")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    

   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func LoginTapped(_ sender: Any) {
        
        let email = emailTF.text!
        let password = passwordTF.text!
        
        
        //Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil{
                
                let ac = UIAlertController(title: "Invalid Credentials", message: "", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel)
            ac.addAction(action)
                self.present(ac, animated: true)
            }
            else{
                
                 self.tansitionToHome()
                
            }
        }
    }
    
    func tansitionToHome(){
        
        let homeViewController = storyboard?.instantiateViewController(identifier: "HomeTVC") as! HomeTableViewController
        
    //    homeViewController.match =  Matches.shared[ind]
        
        navigationController?.pushViewController(homeViewController, animated: true)
       
//        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
//        navigationController?.pushViewController( homeViewController!, animated: true)
//
//       // view.window?.rootViewController = homeViewController
//        //view.window?.makeKeyAndVisible()
    }
    
    
    

}
