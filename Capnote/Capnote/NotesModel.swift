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
    
    init() {
        ref = FIRDatabase.database().reference()
    }
    
}
