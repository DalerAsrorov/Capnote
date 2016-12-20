//
//  UIServices.swift
//  Capnote
//
//  Created by Daler Asrorov on 12/20/16.
//  Copyright © 2016 Daler Asrorov. All rights reserved.
//
import UIKit

class UIServices: NSObject {
    
    func hideNavigationBar(controller: UIViewController) -> Void {
        controller.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
