//
//  UserServices.swift
//  Capnote
//
//  Created by Daler Asrorov on 2/11/17.
//  Copyright © 2017 Daler Asrorov. All rights reserved.
//

import UIKit

class UserServices: NSObject {
    var username: String
    var email: String
    var profileImageSrc: String
    var infoMajor: String
    var infoSchool: String
    var numOfSubs: Int
    
    // defaults for local storage
    let defaults = UserDefaults.standard
    
    // data structure for keys
    enum StorageKeys: String {
        case username = "username"
        case fullName = "fullName"
        case email = "email"
        case profileImgSrc = "img"
        case infoMajor = "major"
        case infoSchool = "school"
        case numOfSubs = "numOfSubs"
        case info = "info"
        case stats = "stats"
    }
    
    override init() {
        self.username = ""
        self.email = ""
        self.profileImageSrc = ""
        self.infoMajor = ""
        self.infoSchool = ""
        self.numOfSubs = 0
    }
    
    func storeUserInfoToLocalStorage(username: String, fullName: String, email: String, profileImageSrc: String, infoMajor: String, infoSchool: String, numOfSubs: Int) {
        
        self.defaults.setValue(username, forKey: StorageKeys.username.rawValue)
        self.defaults.setValue(fullName, forKey: StorageKeys.fullName.rawValue)
        self.defaults.setValue(email, forKey: StorageKeys.email.rawValue)
        self.defaults.setValue(profileImageSrc, forKey: StorageKeys.profileImgSrc.rawValue)
        self.defaults.setValue(infoMajor, forKey: StorageKeys.infoMajor.rawValue)
        self.defaults.setValue(infoSchool, forKey: StorageKeys.infoSchool.rawValue)
        self.defaults.setValue(numOfSubs, forKey: StorageKeys.numOfSubs.rawValue)
    }
    
    func storeUserInfoToLocalStorage(userDict: [String: Any], username: String) {
        let dictionary = userDict as! Dictionary<String, AnyObject>
        self.defaults.setValue(username, forKey: StorageKeys.username.rawValue)
        //        print(defaults.string(forKey: StorageKeys.username.rawValue), " : ", StorageKeys.username.rawValue)
        //        self.defaults.setValue(dictionary[StorageKeys.info.rawValue]?["fullName"], forKey: StorageKeys.fullName.rawValue)
        //        print(defaults.string(forKey: StorageKeys.fullName.rawValue), " : ", StorageKeys.fullName.rawValue)
        self.defaults.setValue(dictionary[StorageKeys.email.rawValue], forKey: StorageKeys.email.rawValue)
        self.defaults.setValue(dictionary[StorageKeys.profileImgSrc.rawValue], forKey: StorageKeys.profileImgSrc.rawValue)
        
        self.defaults.setValue(dictionary[StorageKeys.info.rawValue]?[StorageKeys.infoMajor.rawValue], forKey: StorageKeys.infoMajor.rawValue)
        //        print(defaults.string(forKey: StorageKeys.infoMajor.rawValue), " : ", StorageKeys.infoMajor.rawValue)
        self.defaults.setValue(dictionary[StorageKeys.info.rawValue]?[StorageKeys.infoSchool.rawValue], forKey: StorageKeys.infoSchool.rawValue)
        self.defaults.setValue(dictionary[StorageKeys.stats.rawValue]?[StorageKeys.numOfSubs.rawValue], forKey: StorageKeys.numOfSubs.rawValue)
        
    }
    
    func gerUserDataDictFromStorage() -> Any {
        return [
            StorageKeys.username.rawValue: defaults.string(forKey: StorageKeys.username.rawValue),
            StorageKeys.fullName.rawValue: defaults.string(forKey: StorageKeys.fullName.rawValue),
            StorageKeys.email.rawValue: defaults.string(forKey: StorageKeys.email.rawValue),
            StorageKeys.profileImgSrc.rawValue: defaults.string(forKey: StorageKeys.profileImgSrc.rawValue),
            StorageKeys.infoMajor.rawValue: defaults.string(forKey: StorageKeys.infoMajor.rawValue),
            StorageKeys.infoSchool.rawValue: defaults.string(forKey: StorageKeys.infoSchool.rawValue),
            StorageKeys.numOfSubs.rawValue: defaults.string(forKey: StorageKeys.numOfSubs.rawValue)
        ]
    }
}
