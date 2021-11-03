//
//  ConversationViewController.swift
//  MessengerApplication
//
//  Created by administrator on 27/10/2021.
//

import UIKit
import Firebase
import JGProgressHUD


class ConversationViewController: UIViewController {
    

    
    
    private let spinner = JGProgressHUD(style: .dark)
    
    private var conversations = [Conversation]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.isHidden = true // first fetch the conversations, if none (don't show empty convos)
        
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private let noConversationsLabel: UILabel = {
        let label = UILabel()
        label.text = "No conversations"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 21, weight: .medium)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didTapComposeButton))
        view.addSubview(tableView)
        view.addSubview(noConversationsLabel)
        setupTableView()
        fetchConversations()
        //        DatabaseManger.shared.test()
        startListeningForAllConversations()
    }
    
    private func startListeningForAllConversations() {
      guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
                   return
               }
        
      ///  let email =  "sara444@hotmail.com"
                print("starting conversation fetch")
                
                let safeEmail = DatabaseManger.safeEmail(emailAddress: email)
                
                DatabaseManger.shared.getAllConversations(for: safeEmail) { [weak self] result in
                    switch result {
                    case .success(let conversations):
                        print("successfully got conversation models")
                        guard !conversations.isEmpty else {
                            return
                        }
                        self?.conversations = conversations
                        
                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                        }
                    case .failure(let error):
                        print("failed to get convos \(error)")
                        
                    }
                   
                }

        
    }
    
    @objc private func didTapComposeButton(){
        // present new conversation view controller
        // present in a nav controller
        
        let vc = NewConversationViewController()
        vc.completion = {[weak self]result in
          print ("\(result)")
            self?.creatNewConversation(result : result)
        }
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC,animated: true)
    }
    
    
        private func creatNewConversation (result:[String : String]){
            
          //  let vc = ChatViewController()
      //        let vc =  storyboard?.instantiateViewController(withIdentifier: "chat") as!ChatViewController
                   ///  vc.title = "Jenny Smith"
             // vc.navigationItem.largeTitleDisplayMode = .never     navigationController?.pushViewController(vc, animated: true)
        }
        
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
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
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchConversations(){
        // fetch from firebase and either show table or label
        
        tableView.isHidden = false
    }
}
extension ConversationViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Hello World"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    // when user taps on a cell, we want to push the chat screen onto the stack
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let chat = conversations[indexPath.row]
        let chatView = ChatViewController(with: chat.otherUserEmail, id: chat.id)
        navigationController?.pushViewController(chatView, animated: true)
        
    }
    
    
}
