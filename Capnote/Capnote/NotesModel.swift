//
//  NotesModel.swift
//  Capnote
//
//  Created by Daler Asrorov on 12/15/16.
//  Copyright © 2016 Daler Asrorov. All rights reserved.
//

import UIKit
import FirebaseDatabase

class NotesModel {

    var ref: FIRDatabaseReference!
    var indexCounter: Int
    
    init() {
        self.ref = FIRDatabase.database().reference()
        self.indexCounter = 0
    }
    
    func generateNoteKey() -> Int64 {
        let currentMillisecDate = NSDate().timeIntervalSince1970
        return Int64(currentMillisecDate)
    }
    
    func addFileToDatabaseForUser(noteID: String, url: String) {
        let generatedFileKey = String(self.indexCounter)
        self.ref.child("notes").child(noteID).child("files").updateChildValues([
            generatedFileKey: url
        ])
        self.indexCounter += 1
    }
    
    // username, title, images, description, channel
    func addNote(
        username: String,
        title: String,
        desc: String,
        channel: String,
        completion: @escaping (_ noteKey: String) -> Void
    )
    {
        let noteID = String(generateNoteKey())
        
        self.ref.child("notes").child(noteID).setValue(
            [
                "username": username,
                "info": [
                    "title": title,
                    "desc": desc,
                    "channel": channel
                ]
            ],
            withCompletionBlock:
            {
              (error, snapshot) in
                if error != nil {
                    print("ERROR: Couldn't upload the file --- ", error!)
                } else {
                    print("Uploaded note to appropriate place! ", snapshot)
                    completion(noteID)
                }
            }
        )
        print("\n\n***Successfully uploaded new note", title, "to Firebase Storage!***")
    }

    
//    func addFiles
}
