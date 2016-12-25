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
    let baseColor = UIColor(red:0.90, green:0.32, blue:0.22, alpha:1.0)
    let subBaseColor = UIColor(red:1.00, green:0.78, blue:0.27, alpha:1.0)
    let baseColorCG: CGColor
    
    override init() {
        baseColorCG = self.baseColor.cgColor
    }
    
    func hideNavigationBar(controller: UIViewController) -> Void {
        controller.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
