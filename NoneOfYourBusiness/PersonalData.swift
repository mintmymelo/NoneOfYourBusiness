//
//  PersonalData.swift
//  NoneOfYourBusiness
//
//  Created by Penpitcha Natisupalak on 10/25/2559 BE.
//  Copyright © 2559 Penpitcha Natisupalak. All rights reserved.
//

import Foundation
import RealmSwift

class PersonalData: Object {
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
    
    dynamic var firstName =  ""
    dynamic var lastName = ""
    dynamic var nickname = ""
    dynamic var age = 0
    dynamic var gender = ""
    
    
}
    