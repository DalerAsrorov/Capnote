//
//  UserModel.swift
//  Capnote
//
//  Created by Daler Asrorov on 12/17/16.
//  Copyright © 2016 Daler Asrorov. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class UserModel: NSObject {
    private var ref: FIRDatabaseReference!
    private var refAuth = FIRAuth.auth()
    private var userServices = UserServices()
    
    override init() {
        ref = FIRDatabase.database().reference()
    }
    
    func addUser(username: String, email: String, school: String, major: String, imageURL: String, numberOfSubs: Int?) {
        self.ref.child("users").child(username).setValue([
            "email": email,
            "info": ["major": major, "school": school],
            "stats": ["numOfSubs": numberOfSubs],
            "img": imageURL
        ])
    }
    
    func setToLocalStorage(completion: @escaping (_ noteKey: [String:Any]) -> Void) {
        let userID = refAuth?.currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let dict = snapshot.value as? [String: Any] {
                    self.userServices.storeUserInfoToLocalStorage(userDict: dict)
                    completion(dict)
                }
            }
        })
    }
}
