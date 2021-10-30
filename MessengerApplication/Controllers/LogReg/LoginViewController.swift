//
//  ViewController.swift
//  MessengerApplication
//
//  Created by administrator on 27/10/2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var EmailLabel: UILabel!
    
    @IBOutlet weak var PassworLabel: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var accountlabel: UILabel!
    
    
    @IBAction func LogInButton(_ sender: UIButton) {
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

