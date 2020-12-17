//
//  RegisterViewController.swift
//  TestApp
//
//  Created by Jyoti Mitkar on 13/11/20.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    let dbManager = DBHelper()
    
    //MARK: - ViewController Life Cycle Methods
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "Register"
        
        //Adding back button in navigation bar
        let backButton = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(self.handleBackButtonClick))
        self.navigationItem.leftBarButtonItem  = backButton
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
    }
    
    //MARK: - Navigation Bar button Methods
    @objc func handleBackButtonClick() {
        
        print("LOGINVIEWCONTROLLER keyboardWillShow called")
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - IBOutlet Methods
    @IBAction func registerButtonClick(_ sender: Any) {
        
        //Optional binding
        if let name = nameTextField.text, let username = userNameTextField.text, let password = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text {
            
            if name.count < 6 {
                Helper.showAlertWith(title: "Error", message: "Name contains less than 6 characters", viewController: self)
            }
            else if username.count < 6 {
                Helper.showAlertWith(title: "Error", message: "Username contains less than 6 characters", viewController: self)
            }
            else if password.count != 6 {
                Helper.showAlertWith(title: "Error", message: "Maximum length of the password should be 6", viewController: self)
            }
            else if password != confirmPassword{
                Helper.showAlertWith(title: "Error", message: "Password does not match with confirm password", viewController: self)
            }
            else {
                                
                let userDetails = User(name: name, username: username, password: password)
                let status = dbManager.insert(user: userDetails)
                
                if status {
                    
                    let storyboard = UIStoryboard(name: "User", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "hometabbarcontroller") //Object of HomeViewController
                    self.present(vc, animated: true, completion: nil)
                    
                }
                else {
                    Helper.showAlertWith(title: "Error", message: "Error occured while saving data into database", viewController: self)
                }
            }
            
            
        }
        else {
            Helper.showAlertWith(title: "Error", message: "Username, password or name contain nil value", viewController: self)
        }
        
    }
    
}

extension RegisterViewController:UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        
        if textField == nameTextField {
            return newString.length <= NAME_MAX_LENGTH
        }
        else if textField == userNameTextField {
            return newString.length <= USERNAME_MAX_LENGTH
        }
        else if textField == passwordTextField {
            return newString.length <= PASSWORD_LENTH
        }
        else if textField == confirmPasswordTextField {
            return newString.length <= PASSWORD_LENTH
        }
        
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
