//
//  HomeViewController.swift
//  TestApp
//
//  Created by Jyoti Mitkar on 13/11/20.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var buddyListTableView: UITableView!

    var tupleArray = (501, "Not implemented") //  -----> Tuple in Array Formatte
    var tupleDictionary = (name:"Jyoti", status:"Online", profileIcon:"defaultIcon") // -----> Tuple in dictionary formate
    var buddlyListArray = [(name:String, status:String, profileIcon:String)]() // Array of tuple : Dictionary
    
    let dbManager = DBHelper()
    var users : [User] = [] //Array of user

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Contacts"
        self.navigationItem.hidesBackButton = true //Hides back button
                
        let rightButton = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(self.handleSignOutButtonClick))
        self.navigationItem.rightBarButtonItem  = rightButton
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        
        print("tupleArray first object =============== : \(tupleArray.0)")
        print("tupleArray second object =============== : \(tupleArray.1)")
        
        
        print("tupleDictionary first object =============== : \(tupleDictionary.name)")
        print("tupleDictionary second object =============== : \(tupleDictionary.status)")
        print("tupleDictionary third object =============== : \(tupleDictionary.profileIcon)")

        
        buddlyListArray.append(("Jyoti","I am available. I am available. I am available. I am available","defaultIcon"))
        buddlyListArray.append(("Ash","Online","defaultIcon"))
        buddlyListArray.append(("Madhuri","Away","defaultIcon"))
        buddlyListArray.append(("Mayuri","Busy","defaultIcon"))
        buddlyListArray.append(("Kirti","Online","defaultIcon"))
        
        users = dbManager.getUserDetails()

        //Remove empty rows of tableview
        buddyListTableView.tableFooterView = UIView()
        buddyListTableView.rowHeight = UITableView.automaticDimension
        
    }
    
    //MARK: - Navigation Bar button Methods
    @objc func handleSignOutButtonClick() {
        print("LOGINVIEWCONTROLLER keyboardWillShow called")
        self.dismiss(animated: true, completion: nil)
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return buddlyListArray.count
        return users.count
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "buddylisttableviewcell") as? BuddyListTableViewCell

        if cell == nil {
            cell = BuddyListTableViewCell(style: .default, reuseIdentifier: "buddylisttableviewCell")
        }

//        cell?.profileIconImageView.image = UIImage(named: buddlyListArray[indexPath.row].profileIcon)
//        cell?.nameLabel.text = buddlyListArray[indexPath.row].name
//        cell?.statusLabel.text = buddlyListArray[indexPath.row].status
        
        cell?.profileIconImageView.image = UIImage(named: "defaultIcon")
        cell?.nameLabel.text = users[indexPath.row].name
        cell?.statusLabel.text = "Online"
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("tableView didSelectRowAt CALLED")
    }
}
