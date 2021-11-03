//
//  NewConversationViewController.swift
//  MessengerApplication
//
//  Created by administrator on 27/10/2021.
//

import UIKit
import JGProgressHUD

class NewConversationViewController: UIViewController {
    public var completion :( ([String:String])-> (Void))?
    
    private let spinner = JGProgressHUD()
    private var user = [[String:String]]()
    private var results = [[String:String]]()
    private var hasFetched = false
    
    private let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Seach for User..."
        return searchBar
    }()
    
    private var tableView :UITableView = {
        
        let table = UITableView ()
        table.isHidden = true
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private let noResultLable : UILabel = {
        let lable = UILabel()
        lable.isHidden = true
        lable.text = "No Result"
        lable.textAlignment = .center
        lable.textColor = .green
        lable.font = .systemFont(ofSize: 21, weight: .medium)
        return lable
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(noResultLable)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Cancel", style: .done, target: self, action: #selector(dismissSelf))
        
        searchBar.becomeFirstResponder()
    }

   @objc private func dismissSelf (){
    dismiss(animated:true , completion :nil)
    
    }
}

extension NewConversationViewController :UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = results [indexPath.row]["name"]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // start Converstion
        let targerUserDta = results[indexPath.row]
        dismiss(animated: true , completion: { [weak self ] in
            self?.completion?(targerUserDta)
        })
        
    }
    
    
}

extension NewConversationViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchUser(query: searchBar.text!)
        
    }
    
    


    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text,!text.replacingOccurrences(of: "", with: "").isEmpty else{
            return
        }
        searchBar.resignFirstResponder()
        results.removeAll()
        spinner.show(in: view)
        self.searchUser(query: text)
        
    }
    func searchUser(query:String){
        if hasFetched {
            filterUsers(with: query)
            
        }
        else {
            DatabaseManger.shared.getAllUsers(completion: {[weak self]result in
                switch result {
                case.success(let userCollection):
                    self?.hasFetched = true
                    self?.user = userCollection
                    self?.filterUsers(with: query)
                case .failure(let error_):
                    print ("failed to get users : \(error_)")
                }
            })
        }
    }
    func filterUsers(with term : String){
        guard hasFetched else {
            return
        }
       let results :[[String:String]] = self.user.filter ({
            guard let name = $0["name"]?.lowercased()  else {
                return false
            }
            return name.hasPrefix(term.lowercased())
        })
        self.results = results
        updtateUI()
    }
    func updtateUI (){
        if results.isEmpty {
            self.noResultLable.isHidden = false
            self.tableView.isHidden = true
        }
        else {
            self.noResultLable.isHidden = true
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
}
