//
//  UIServices.swift
//  Capnote
//
//  Created by Daler Asrorov on 12/20/16.
//  Copyright © 2016 Daler Asrorov. All rights reserved.
//
import UIKit

class UIServices: NSObject {
    let buttonRoundRadius = CGFloat(10.0)
    
    func hideNavigationBar(controller: UIViewController) -> Void {
        controller.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
