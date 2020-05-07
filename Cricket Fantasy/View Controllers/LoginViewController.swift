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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = true
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
        
        // Read email and password text files
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
    
    @IBAction func cancel(){
        let view = storyboard?.instantiateViewController(identifier: "VC") as! ViewController
        navigationController?.pushViewController(view, animated: true)
    }
    func tansitionToHome(){
        
        // Navigated to Home page
        let homeViewController = storyboard?.instantiateViewController(identifier: "HomeTVC") as! HomeTableViewController
        navigationController?.pushViewController(homeViewController, animated: true)
    }
    
    
    
    
}
