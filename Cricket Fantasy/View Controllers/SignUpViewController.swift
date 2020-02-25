//
//  SignUpViewController.swift
//  Cricket Fantasy
//
//  Created by student on 2/19/20.
//  Copyright © 2020 student. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase


class SignUpViewController: UIViewController {
    
    private var authUser : User? {
        return Auth.auth().currentUser
        
    }


    
    @IBOutlet weak var firstNameTF: UITextField!
    
    @IBOutlet weak var lastnameTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background.jpg")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
       
    }
    
    
    func validateFields() ->Bool{
        
        //check all fields are filled in
        if firstNameTF.text! == "" || lastnameTF.text! == "" || emailTF.text! == "" || passwordTF.text! == ""{
            self.showError("All fields should be filled")
            return false
        }
        
        let passwordcheck = self.passwordCheck(text: passwordTF.text!)

        if passwordcheck == false{
            self.showError("Password not matching with requirements")
            return false
        }
        return true
  
    }
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        if validateFields(){
      
        let firstName = firstNameTF.text!
        let lastName = lastnameTF.text!
        let email = emailTF.text!
        let password = passwordTF.text!

        Auth.auth().createUser(withEmail: email, password: password) { (result , err) in

            if err != nil{
                self.showError("user already exist")
            }
            else{
                // user created suceesfully, now store firstname and lastname in database
                
                let db = Firestore.firestore()
                
                db.collection("users").addDocument(data: ["firstName" : firstName, "lastname" : lastName, "uid": result!.user.uid]) { (error) in
                    
                    if error != nil{
                        self.showError("error saving user data")
                    }
                }
                
                self.tansitionToHome()
             }
            
            
            }
            
        }
        
        
    }
    
    func showError(_ message: String){
        let ac = UIAlertController(title: "not matching", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        ac.addAction(action)
        self.present(ac, animated: true)
    }
    
    func tansitionToHome(){
        
       
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    
 
    func passwordCheck(text : String) -> Bool{
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: text)

    }

}
