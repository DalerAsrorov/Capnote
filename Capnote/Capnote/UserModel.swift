//
//  UserModel.swift
//  Capnote
//
//  Created by Daler Asrorov on 12/17/16.
//  Copyright © 2016 Daler Asrorov. All rights reserved.
//

import UIKit
import FirebaseDatabase

class UserModel: NSObject {
    var ref: FIRDatabaseReference!
    
    override init() {
        ref = FIRDatabase.database().reference()
    }
    
    func addUser(username: String, email: String, school: String, major: String, imageURL: String) {
        self.ref.child("users").child(username).setValue([
            "info": ["major": major, "school": school],
            "email": email,
            "img": imageURL
        ])
    }
}
