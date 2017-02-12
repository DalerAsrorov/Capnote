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
    
    func setToLocalStorage(completion: @escaping (_ noteKey: [String:Any], _ usernameID: String) -> Void) {
        let loginEmail = refAuth?.currentUser?.email
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let dictOfUsers = snapshot.value as? [String: Any] {
                    for (keyUsernameItem, valueObjectItem) in dictOfUsers {
                        let userInfoDictOptional = valueObjectItem as? Dictionary<String, Any>
                        let userInfoDict = userInfoDictOptional!
                        let dbEmail = userInfoDict["email"] as! String
                        let keyUsernameStr = keyUsernameItem as! String
                        
                        if(dbEmail == loginEmail) {
                            self.userServices.storeUserInfoToLocalStorage(userDict: userInfoDict, username: keyUsernameStr)
                            completion(userInfoDict, keyUsernameStr)
                        }
                    }
                }
            }
        })
    }
}
