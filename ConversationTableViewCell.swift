//
//  ConversationTableViewCell.swift
//  MessengerApplication6
//
//  Created by administrator on 03/11/2021.
//

import UIKit
import SDWebImage
class ConversationTableViewCell: UITableViewCell {
    static let identifier = "ConversationTableViewCell"
    
    
    
    private let userImageView : UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()

    
    private let userMessageLable :UILabel = {
       let lable = UILabel()
        lable.font = .systemFont(ofSize: 19, weight: .regular)
        lable.numberOfLines = 0
        return lable
    }()
    
    private let userNameLable:UILabel = {
       let lable = UILabel()
        lable.font = .systemFont(ofSize: 21, weight: .semibold)
        return lable
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(userImageView)
        contentView.addSubview(userNameLable)
        contentView.addSubview(userMessageLable)
        
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
      
        userImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        userImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        userImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
       
        userNameLable.translatesAutoresizingMaskIntoConstraints = false
        userNameLable.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor,constant: 20).isActive = true
        userNameLable.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor).isActive = true
        
        userMessageLable.translatesAutoresizingMaskIntoConstraints = false
        userMessageLable.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 20).isActive = true
       userMessageLable.topAnchor.constraint(equalTo: userNameLable.bottomAnchor, constant: 5).isActive = true 
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    public func configure(with model:Conversation){
        self.userMessageLable.text = model.latestMessage.text
        self.userNameLable.text = model.name
       
       
        let path = "images/\(model.otherUserEmail)"
        StorageManager.shared.downloadURL(for: path, completion: {[weak self]result in
            switch result {
            case.success(let url):
                URLSession.shared.dataTask(with: url, completionHandler: {data, _,error in
                    guard let data = data ,error == nil else{
                        return
                    }
                    DispatchQueue.main.async {
                        let image = UIImage(data:data)
                        self?.userImageView.image = image
                       
                    }
                }).resume()
                
                
                
            case.failure(let error):
                print ("failer to get image url \(error)")
            }
        })
        
    }

}
