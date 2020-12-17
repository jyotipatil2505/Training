//
//  ProfileIconViewController.swift
//  TestApp
//
//  Created by Jyoti Mitkar on 16/12/20.
//

import UIKit

class ProfileIconViewController: UIViewController {
    
    @IBOutlet weak var profileIconImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.title = "Select Profile Icon"
        
        setProfileIconImageViewLayout()
        addGestureToProfileIcon()
    }
    
    //Internal Access Control Method
    func setProfileIconImageViewLayout() {
        
        DispatchQueue.main.async {
            
            self.profileIconImageView.layer.cornerRadius = self.profileIconImageView.frame.size.width / 2
            self.profileIconImageView.layer.borderWidth = 2
            self.profileIconImageView.layer.borderColor = UIColor.black.cgColor
        }
        
    }
    
    //File Private Access Control Method =================> Gesture Implementation
    fileprivate func addGestureToProfileIcon() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openGallery))
        
        // Optionally set the number of required taps, e.g., 2 for a double click
        tapGestureRecognizer.numberOfTapsRequired = 1
        
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        profileIconImageView.isUserInteractionEnabled = true
        profileIconImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    //Private Method
    @objc private func openGallery() {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = false
        pickerController.mediaTypes = ["public.image", "public.movie"]
        pickerController.sourceType = .photoLibrary
        self.present(pickerController, animated: true, completion: nil)
    }
    
    //Internal Method
    func internalMethod() {
        print("internalMethod CALLED")
    }
    
    //Public Method
    public func publicMethod() {
        print("publicMethod CALLED")
    }
    
    //Open Method
    open func openMethod() {
        print("openMethod CALLED")
    }
}

extension ProfileIconViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("imagePickerControllerDidCancel CALLED")
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("didFinishPickingMediaWithInfo CALLED")
                        
        //picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            ///imageView.image = image
            
            print("SELECTED IMAGE :=================== \(image)")
            profileIconImageView.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func callPrivateMethod() {
        openGallery()
    }
}

class FilePrivateClass {
    
    func callPrivateOpenGalleryMethod() {
        
        let object = ProfileIconViewController()
        //object.openGallery() // Can not call openGallery() method as it is declared with private keyword.
        
    }
    
    func callFilePrivateMethod() {
        let object = ProfileIconViewController()
        object.addGestureToProfileIcon() // Can call addGestureToProfileIcon() method as it is declared with fileprivate keyword.
    }
}

