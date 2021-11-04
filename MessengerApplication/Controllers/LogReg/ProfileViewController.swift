//
//  ProfileViewController.swift
//  MessengerApplication
//
//  Created by administrator on 27/10/2021.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {


    @IBOutlet var tableView: UITableView!
        
        let data = ["Log Out"]
            
        override func viewDidLoad() {
            super.viewDidLoad()
            
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            tableView.delegate = self
            tableView.dataSource = self
             creatTableHeader()
            
            
        }
    
   func creatTableHeader () {
       let user = FirebaseAuth.Auth.auth().currentUser
       let safeEmail = DatabaseManger.safeEmail(emailAddress: user!.email!)
       let urlString = "images/\(safeEmail)"
       StorageManager.shared.downloadURL(for: urlString) { result  in
           switch result {
           case .success(let url):
               let profileImage = UIImageView(frame: .zero)
               profileImage.contentMode = .scaleAspectFill
               profileImage.layer.cornerRadius = 50
               profileImage.layer.masksToBounds = true
               URLSession.shared.dataTask(with: url, completionHandler: {data, _,error in
                   guard let data = data ,error == nil else{
                       return
                   }
                   DispatchQueue.main.async {
                       let image = UIImage(data:data)
                       profileImage.image = image
                       let container = UIView(frame :CGRect(x: 0, y: 0, width: 100, height: 100))
                       container.addSubview(profileImage)
                       profileImage.translatesAutoresizingMaskIntoConstraints = false
                       profileImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
                       profileImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
                       profileImage.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
                       profileImage.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
                       self.tableView.tableHeaderView = container
                      
                   }
               }).resume()
               
           case .failure(let error):
               break
           }
       }
           
       
        
     
    }
    
    
    func downloadImage(imageView:UIImageView ,url:URL){
        URLSession.shared.dataTask(with: url, completionHandler: {data, _,error in
            guard let data = data ,error == nil else{
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data:data)
                imageView.image = image
            }
        }).resume()
    }
    }


    extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = data[indexPath.row]
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = .red
            return cell
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true) // unhighlight the cell
            // logout the user
            
            // show alert
            
            let actionSheet = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
            
            actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { [weak self] _ in
                // action that is fired once selected
                
                guard let strongSelf = self else {
                    return
                }
                
              
                
                do {
                    try FirebaseAuth.Auth.auth().signOut()
                    
                    let vs = self?.storyboard?.instantiateViewController(withIdentifier: "nav")
                    
                    self?.view.window?.rootViewController = vs 
                  
                    
                }
                catch {
                    print("failed to logout")
                }
                
            }))
            
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(actionSheet, animated: true)
        }
        

}
