//
//  NewConversationViewController.swift
//  MessengerApplication
//
//  Created by administrator on 27/10/2021.
//

import UIKit
import JGProgressHUD

class NewConversationViewController: UIViewController {
    private let spinner = JGProgressHUD()
    
    private let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Seach for User..."
        return searchBar
    }()
    
    private var tableView :UITableView {
        let table = UITableView ()
        table.isHidden = true
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return table
    }
    
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
      //  view.backgroundColor = .gray
        navigationController?.navigationBar.topItem?.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Cancel", style: .done, target: self, action: #selector(dismissSelf))
        
        searchBar.becomeFirstResponder()
    }

   @objc private func dismissSelf (){
    dismiss(animated:true , completion :nil)
    
    }
}

extension NewConversationViewController : UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
