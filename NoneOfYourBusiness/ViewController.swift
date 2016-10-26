//
//  ViewController.swift
//  NoneOfYourBusiness
//
//  Created by Penpitcha Natisupalak on 10/22/2559 BE.
//  Copyright © 2559 Penpitcha Natisupalak. All rights reserved.
//

import UIKit
import LocalAuthentication
import RealmSwift

class ViewController: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var insertButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.authenticateUser()
        
        //prints the database location to the debug console
        print(Realm.Configuration.defaultConfiguration.fileURL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // IBActions
    
    
    
    // Touch ID Authentication
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?
        let reasonString = "Authentication is needed to access the app! :)"
        
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success, policyError) -> Void in
            
                if success {
                    
                    print("Authentication Successful !!!! :)")
                    
                } else {
                    
                    switch policyError!.code {
                    case LAError.SystemCancel.rawValue:
                        print("Authentication was cancelled by the system.")
                    case LAError.UserCancel.rawValue:
                        print("Authentication was cancelled by the user.")
                    case LAError.UserFallback.rawValue:
                        print("User selected to enter password.")
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            self.showPasswordAlert()
                        })
                    default:
                        print("Authentication failed! :(")
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            self.showPasswordAlert()
                        })
                    }
                    
                }
                
            })
            
        } else {
            print(error?.localizedDescription)
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.showPasswordAlert()
            })
        }
        
    }
    
    
    
    func showPasswordAlert() {
        let alertController = UIAlertController(title: "Touch ID Password", message: "Please enter your password", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Cancel) { (action) -> Void in
        
            if let textField = alertController.textFields?.first as UITextField? {
                
                if textField.text == "password"{
                 
                    print("Authentication Successful !!!")
                    
                } else {
                    
                    self.showPasswordAlert()
                    
                }
            }
        }
        
        alertController.addAction(defaultAction)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            
            textField.placeholder = "Password"
            textField.secureTextEntry = true
            
        }
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
