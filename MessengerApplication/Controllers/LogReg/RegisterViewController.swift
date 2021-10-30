//
//  RegisterViewController.swift
//  MessengerApplication
//
//  Created by administrator on 27/10/2021.
//

import UIKit

class RegisterViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
        
            }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedPhoto = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageProfile.image = selectedPhoto
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
       /// imagePickerController.sourceType = .camera
        imagePickerController.delegate = self
        present(imagePickerController,animated: true,completion: nil)
        
        
    }
    @IBOutlet weak var imageProfile: UIImageView!
    
    @IBOutlet weak var FirstNameTextField: UITextField!
    
    
    @IBOutlet weak var LastNameTextField: UITextField!
 
    
    @IBOutlet weak var EmailTextFieldReg: UITextField!
    
    
    @IBOutlet weak var PassworTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageProfile.layer.cornerRadius = imageProfile.frame.size.width/2
        imageProfile.clipsToBounds = true 
      
        
        
        // UITapGesture

        
        
        
    }


  
   

}
