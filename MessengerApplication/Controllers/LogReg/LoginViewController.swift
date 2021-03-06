//
//  ViewController.swift
//  MessengerApplication
//
//  Created by administrator on 27/10/2021.
//

import UIKit
import Firebase
import JGProgressHUD
import FBSDKLoginKit

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

       // static func isValidEmail(_ email: String) -> Bool {
            //    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

            //    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            //    return emailPred.evaluate(with: email)
          //  }


        
        
        
        /*FirebaseAuth.Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { [weak self] authResult, error in
           
            guard let result = authResult, error == nil else {
                print("Failed to log in user with email \(String(describing: self.emailTextField))")
                return
            }
            let user = result.user
            print("logged in user: \(user)")
        })*/
        

       
    }
    
    @IBOutlet weak var facbookButton: FBLoginButton!
    
    
   
    
    @IBAction func signInWithGoogleButton(_ sender: UIButton) {
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        
     let vc = storyboard?.instantiateViewController(withIdentifier: "register")as!RegisterViewController
        
      self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    
   
    
    
    /// <#Description#>
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // let continueWithFacebook = FBLoginButton()
       // continueWithFacebook.permissions = ["public_profile", "email"]
       // continueWithFacebook.delegate = self
        
        if let token = AccessToken.current, !token.isExpired {
            
            let token = token.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":"email,name"], tokenString: token, version: nil, httpMethod: .get)
            request.start(completionHandler: { connection,result,error in
                print ("\(result)")
            })
            
            
            }
    
        
        else {
            facbookButton.permissions = ["public_profile", "email"]
            facbookButton.delegate = self
        ////facbookButton.center =
            
         
           
        }
        
        
        
        
    }


    
}

extension LoginViewController : LoginButtonDelegate {
   
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":"email,name"], tokenString: token, version: nil, httpMethod: .get)
        request.start(completionHandler: { connection,result,error in
            print ("\(result)")
        })
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
        print ("Logout")
    }
}
