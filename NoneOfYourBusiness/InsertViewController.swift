//
//  InsertViewController.swift
//  NoneOfYourBusiness
//
//  Created by Penpitcha Natisupalak on 10/25/2559 BE.
//  Copyright © 2559 Penpitcha Natisupalak. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class InsertViewController: UIViewController {
    
    // Properties
    var personalData: PersonalData!
    
    // IBOutlets
    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        
    }
    
    
    // IBActions
    @IBAction func touchSubmit(sender: UIButton) {
        
        print("Press Submit")
        
        addNewPersonalData()
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func addNewPersonalData() {
        
        let realm = try! Realm()
        
        try! realm.write {
            let newPersonalData = PersonalData()
            
            newPersonalData.firstName = firstNameTextfield.text!
            newPersonalData.lastName = lastNameTextField.text!
            newPersonalData.nickname = nicknameTextField.text!
            newPersonalData.age = Int(ageTextField.text!)!
            newPersonalData.gender = genderTextField.text!
            
            realm.add(newPersonalData)
            self.personalData = newPersonalData
        }
        
        print("add " + personalData.firstName)
    }
    
}
