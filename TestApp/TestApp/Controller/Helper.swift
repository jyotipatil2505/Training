//
//  Helper.swift
//  TestApp
//
//  Created by Jyoti Mitkar on 11/11/20.
//

import UIKit

class Helper: NSObject {
    
    static var helperObject = "Helper object is a class object" //Class Object
    var helperInstance = "Helper Instance is a class instance" // Instance Object
    
    //Instance method
    func additionOf(firstValue: Int, secondValue: Int) -> Int {
        return firstValue + secondValue
    }
    
    //Class method
    class func multiply(firstValue: Int, secondValue: Int) -> Int {
        return firstValue * secondValue
    }
    
    //Class Method
    class func showAlertWith(title: String, message: String, viewController: UIViewController) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle:UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        { action -> Void in
            
            //Write logic here after clicking OK Button
            
        })
        
        /*alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default)
        { action -> Void in
            
            //Write logic here after clicking Cancel Button
        })*/
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}

public class PublicClass {
    
    public func testMethod() {
        
    }
}

open class OpenClass {
    
    open func openMethod() {
        print("OpenClass openMethod CALLED")
    }
}

