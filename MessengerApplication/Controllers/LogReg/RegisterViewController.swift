//
//  RegisterViewController.swift
//  MessengerApplication
//
//  Created by administrator on 27/10/2021.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
        
            }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedPhoto = info [.editedImage] as? UIImage{
        imageProfile.image = selectedPhoto
        dismiss(animated: true, completion: nil)
    }
        else {
            print ("image not found ")
        }
    }
    @IBAction func selectImageFromPhotoLibraryOrCamera(_ sender: UITapGestureRecognizer) {
        showPhotoAlter ()
       
    }
    func showPhotoAlter (){
        let alert = UIAlertController(title: "Take photo From",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style:.default, handler: { UIAlertAction in
            self.getPhoto(type: .camera)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Photo Library", style:.default, handler: { UIAlertAction in
            self.getPhoto(type: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style:.cancel, handler:nil ))
         present (alert , animated: true ,completion: nil)
    }
        
    func getPhoto (type :UIImagePickerController.SourceType){
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = type
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        present (imagePickerController,animated: true ,completion: nil)
    }
   
    @IBOutlet weak var imageProfile: UIImageView!
    
    @IBOutlet weak var FirstNameTextField: UITextField!
    
    
    @IBOutlet weak var LastNameTextField: UITextField!
 
    
    @IBOutlet weak var EmailTextFieldReg: UITextField!
    
    
    @IBOutlet weak var PassworTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        imageProfile.layer.cornerRadius = imageProfile.frame.size.width/2
        imageProfile.layer.borderWidth = 1.0
        imageProfile.layer.borderColor = UIColor.black.cgColor
        imageProfile.clipsToBounds = true
        
        
    }


  
   
    @IBAction func registerButton(_ sender: UIButton) {
        FirebaseAuth.Auth.auth().createUser(withEmail: EmailTextFieldReg.text!, password: PassworTextField.text!, completion: { authResult , error  in
            guard let result = authResult, error == nil else {
                print("Error creating user")
                return
            }
            let user = result.user
            print("Created User: \(user)")
        })
    }
    
}
