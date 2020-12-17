//
//  LoginViewController.swift
//  TestApp
//
//  Created by Jyoti Mitkar on 10/11/20.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    let dbManager = DBHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("LOGINVIEWCONTROLLER - viewDidLoad METHOD CALLED")
        
        self.title = "Login"
        
        //Adding back button in navigation bar
        let backButton = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(self.handleBackButtonClick))
        self.navigationItem.leftBarButtonItem  = backButton
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black

    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("LOGINVIEWCONTROLLER - viewWillAppear CALLED")
        print("applicationState in LoginViewController ===============: \(UserDefaults.standard.value(forKey: "applicationState") ?? "")")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("LOGINVIEWCONTROLLER - viewWillDisappear METHOD CALLED")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("LOGINVIEWCONTROLLER - viewDidAppear METHOD CALLED")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("LOGINVIEWCONTROLLER - viewDidDisappear METHOD CALLED")
    }
    
    override func didReceiveMemoryWarning() {
        print("LOGINVIEWCONTROLLER - didReceiveMemoryWarning METHOD CALLED")
    }
    
    //MARK: - Navigation Bar button Methods
    @objc func handleBackButtonClick() {
        
        print("LOGINVIEWCONTROLLER keyboardWillShow called")
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func loginButtonClick(_ sender: Any) {
        
        print("LOGINVIEWCONTROLLER - loginButtonClick METHOD CALLED")
              
        //Optional binding
        if let username = usernameTextField.text, let password = passwordTextField.text {
            
            if username.count < 6 {
                Helper.showAlertWith(title: "Error", message: "Username contains less than 6 characters", viewController: self)
            }
            else if password.count != 6 {
                Helper.showAlertWith(title: "Error", message: "Maximum length of the password should be 6", viewController: self)
            }
            else {
                
                if let userDetails = dbManager.authenticateUserWith(userName: username, userPassword: password) {
                    
                    UserDefaults.standard.set(userDetails.username, forKey: "loggedInUserName")
                    
                    let storyboard = UIStoryboard(name: "User", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "hometabbarcontroller") //Object of HomeViewController
                    self.present(vc, animated: true, completion: nil)
                }
                else {
                    Helper.showAlertWith(title: "Error", message: "Failed to authenticate \(username)", viewController: self)
                }
            }            
        }
        else {
            Helper.showAlertWith(title: "Error", message: "Username, password contain nil value", viewController: self)
        }
    }
}


extension LoginViewController:UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        
        if textField == usernameTextField {
            return newString.length <= USERNAME_MAX_LENGTH
        }
        else if textField == passwordTextField {
            return newString.length <= PASSWORD_LENTH
        }
        
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
