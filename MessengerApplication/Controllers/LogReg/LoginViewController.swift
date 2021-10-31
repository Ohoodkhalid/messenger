//
//  ViewController.swift
//  MessengerApplication
//
//  Created by administrator on 27/10/2021.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var EmailLabel: UILabel!
    
    @IBOutlet weak var PassworLabel: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var accountlabel: UILabel!
    
    
    @IBAction func LogInButton(_ sender: UIButton) {
        FirebaseAuth.Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { authResult, error in
            guard let result = authResult, error == nil else {
                print("Failed to log in user with email \(self.emailTextField)")
                return
            }
            let user = result.user
            print("logged in user: \(user)")
        })
        

       
    }
    
    
    
    @IBAction func continueWithFacebook(_ sender: UIButton) {
    }
    
    
    @IBAction func signInWithGoogleButton(_ sender: UIButton) {
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
     let vc = storyboard?.instantiateViewController(withIdentifier: "register")as!RegisterViewController
        
      self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    
    

    override func viewDidLoad() {
        image.layer.cornerRadius = image.frame.size.width/2
        super.viewDidLoad()
      
        
        
        
        
        
        
        
        
        
        
        
        
      //UITapGesture

        
        
        
        // Do any additional setup after loading the view.
        
        
    }


    
}

