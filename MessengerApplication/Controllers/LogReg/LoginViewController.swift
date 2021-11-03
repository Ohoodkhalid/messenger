//
//  ViewController.swift
//  MessengerApplication
//
//  Created by administrator on 27/10/2021.
//

import UIKit
import Firebase
import JGProgressHUD

class LoginViewController: UIViewController {
    private let spinner = JGProgressHUD(style: .dark)
    
    
    @IBOutlet weak var EmailLabel: UILabel!
    
    @IBOutlet weak var PassworLabel: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var accountlabel: UILabel!
    
    
    @IBAction func LogInButton(_ sender: UIButton) {
        
        spinner.show(in: view)
        // Firebase Login
        FirebaseAuth.Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { [weak self] authResult, error in
            guard let strongSelf = self else {
                return
            }
            DispatchQueue.main.async {
                strongSelf.spinner.dismiss() 
            }
            
            guard let result = authResult, error == nil else {
                print("Failed to log in user with email \(String(describing: self!.emailTextField))")
                return
            }
            let user = result.user
            UserDefaults.standard.set(self!.emailTextField.text , forKey: "email")
            print("logged in user: \(user)")
            // if this succeeds, dismiss
            let vs = self?.storyboard?.instantiateViewController(withIdentifier: "home")
            strongSelf.view.window?.rootViewController = vs!
           // strongSelf.navigationController?.dismiss(animated: true, completion: nil)
        })

        
        /*FirebaseAuth.Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { [weak self] authResult, error in
           
            guard let result = authResult, error == nil else {
                print("Failed to log in user with email \(String(describing: self.emailTextField))")
                return
            }
            let user = result.user
            print("logged in user: \(user)")
        })*/
        

       
    }
    
    
    
    @IBAction func continueWithFacebook(_ sender: UIButton) {
    }
    
    
    @IBAction func signInWithGoogleButton(_ sender: UIButton) {
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        
     let vc = storyboard?.instantiateViewController(withIdentifier: "register")as!RegisterViewController
        
      self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    
    
    
    /// <#Description#>
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.image.layer.cornerRadius = image.frame.size.width/2
     
      
        
        
        
        
        
        
        
        
        
        
        
        
      //UITapGesture

        
        
        
        // Do any additional setup after loading the view.
        
        
    }


    
}

