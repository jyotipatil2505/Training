//
//  HomeViewController.swift
//  TestApp
//
//  Created by Jyoti Mitkar on 10/11/20.
//

import UIKit

class HomeViewController_Old: UIViewController,UITextFieldDelegate {
    
    var titleString = "Home" //Global Variable (Instances of HomeViewController)
    
    var firstName:String? //Optionals (By default, this will contain nil value)
    var lastName:String! //Optionals (By default, this will contain nil value)
    var address:String = "" //Non - Optionals 
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messageTextFieldBottomConstraint: NSLayoutConstraint!
    
    //MARK: - View Controller Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("HomeViewController - viewDidLoad CALLED")
        print("applicationState in HomeViewController ===============: \(UserDefaults.standard.value(forKey: "applicationState") ?? "")")
        
        //Registering user defined notification
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleAppForegroundLogic), name: NSNotification.Name(rawValue: "com.reliance.jiomeet.handleappforegroundlogic"), object: nil)
        
        //Registering system provided notification
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("HomeViewController - viewWillAppear CALLED")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("HomeViewController - viewWillDisappear METHOD CALLED")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("HomeViewController - viewDidAppear METHOD CALLED")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("HomeViewController - viewDidDisappear METHOD CALLED")
    }
    
    override func didReceiveMemoryWarning() {
        print("HomeViewController - didReceiveMemoryWarning METHOD CALLED")
    }
    
    //MARK: - Notification Methods
    @objc func handleAppForegroundLogic(notification: NSNotification) {
        
        print("HomeViewController handleAppForegroundLogic called")
        
        let userInfo = notification.userInfo ?? [:]
        let state = userInfo["state"] ?? ""
        let message = "Application moved to \(state)"
        
        Helper.showAlertWith(title: "Alert", message: message, viewController: self)
    }
    
    //MARK: - Keyboard Notification Method
    @objc func keyboardWillShow(notification: NSNotification) {
        
        print("HomeViewController keyboardWillShow called")
        //Helper.showAlertWith(title: "Alert", message: "Keyboard appeared", viewController: self)
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            messageTextFieldBottomConstraint.constant = keyboardHeight + 16.0
        }
        
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        print("HomeViewController keyboardWillHide called")
        //Helper.showAlertWith(title: "Alert", message: "Keyboard disappeared", viewController: self)
        messageTextFieldBottomConstraint.constant = 16.0
    }
    
    //MARK: - TextField Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print("HomeViewController textFieldShouldReturn called")
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        print("HomeViewController textFieldShouldBeginEditing called")
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        print("HomeViewController shouldChangeCharactersIn called ====================== : \(string)")
        return true
    }
    
    //MARK: - IBOutlet Methods
    @IBAction func backButtonClick(_ sender: Any) {
        print("HomeViewController - backButtonClick CALLED")
        print("TITLE STRING IN HOME VIEWCONTROLLER ============: \(titleString)") //Class global variable
        
        UserDefaults.standard.removeObject(forKey: "applicationState")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButtonClick(_ sender: Any) {
        
        //Unregistering notification
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "com.reliance.jiomeet.handleappforegroundlogic"), object: nil)
        
        /* multiply and addition are local variable */
        
        //Logic of Class Method invocation
        let multiply = Helper.multiply(firstValue: 2, secondValue: 3)
        print("Multiply OF 2 AND 3 ================: \(multiply)")
        
        //Logic of Instance Method invocation
        let helperObject = Helper()
        let addition = helperObject.additionOf(firstValue: 2, secondValue: 3)
        print("Addition OF 2 AND 3 ================: \(addition)")
        
    }
    
    @IBAction func setNameButtonClick(_ sender: Any) {
        
        /*firstName = "Jyoti"
        lastName = "Mitkar"
        address = "Mumbai"
        
        let fullName = (firstName ?? "") + " " + (lastName ?? "")
        Helper.showAlertWith(title: "Name", message: fullName, viewController: self)*/
        
//        let helperClassObject = Helper.helperObject
//        let message = "\(helperClassObject)"
//        Helper.showAlertWith(title: "Alert", message: message, viewController: self)
        
        let helper = Helper()
        let helperInstance = helper.helperInstance
        let message = "\(helperInstance)"
        Helper.showAlertWith(title: "Alert", message: message, viewController: self)

    }
}
