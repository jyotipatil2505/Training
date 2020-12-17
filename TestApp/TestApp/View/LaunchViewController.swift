//
//  LaunchViewController.swift
//  TestApp
//
//  Created by Jyoti Mitkar on 13/11/20.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Chat"
    }
    
    
    //MARK: - IBOutlet Methods
    @IBAction func registerButtonClick(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "registerviewcontroller")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginButtonClick(_ sender: Any) {
                
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "loginviewcontroller")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
