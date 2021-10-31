//
//  ConversationViewController.swift
//  MessengerApplication
//
//  Created by administrator on 27/10/2021.
//

import UIKit
import Firebase

class ConversationViewController: UIViewController {

    override func viewDidLoad() {
        view.backgroundColor = .red
        super.viewDidLoad()
        do {
                   try FirebaseAuth.Auth.auth().signOut()
               }
               catch {
               }
            DatabaseManger.shared.test()
           }
           override func viewDidAppear(_ animated: Bool) {
               super.viewDidAppear(animated)
         
               validateAuth()
    
    }
    private func validateAuth(){
            // current user is set automatically when you log a user in
            if FirebaseAuth.Auth.auth().currentUser == nil {
                // present login view controller
                let vc = LoginViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                present(nav, animated: false)
            }
        }

    

}
