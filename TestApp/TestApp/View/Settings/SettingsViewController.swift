//
//  SettingsViewController.swift
//  TestApp
//
//  Created by Jyoti Mitkar on 23/11/20.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    let dbManager = DBHelper()
    var username = String()
    
    //MARK: - Life cycle of ViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        username = UserDefaults.standard.object(forKey: "loggedInUserName") as? String ?? ""
        usernameLabel.text = "Username : \(username)"
    }

    //MARK: - IBAction Methods
    @IBAction func updateButtonClick(_ sender: Any) {
        
        //Optional binding
        if let name = nameTextField.text {
            
            if name.count < 6 {
                
                Helper.showAlertWith(title: "Error", message: "Name contains less than 6 characters", viewController: self)
            }
            else {
                       
                let status = dbManager.updateWith(name: name, userName: username)
                
                if status {
                    
                    Helper.showAlertWith(title: "Success", message: "Name has been updated successfully", viewController: self)
                    
                }
                else {
                    Helper.showAlertWith(title: "Error", message: "Error occured while updating name into database", viewController: self)
                }
            }
            
        }
        else {
            Helper.showAlertWith(title: "Error", message: "Name contain nil value", viewController: self)
        }
    }
    
    
    @IBAction func userProfileButtonClick(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "userprofileviewcontroller")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func showProfileIconButtonClick(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "profileiconviewcontroller")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//MARK: - Extension of SettingsViewController
extension SettingsViewController:UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        
        if textField == nameTextField {
            return newString.length <= NAME_MAX_LENGTH
        }
        
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
