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
    let borderWidth = CGFloat(1)
    let baseColorCG: CGColor
    
    private let DEFAULT_CORNER_RADIUS = 4.0
    private let DEFAULT_BORDER_COLOR = UIColor(red:0.90, green:0.32, blue:0.22, alpha:1.0)
    private let DEFAULT_BORDER_WIDTH = 1
    
    override init() {
        baseColorCG = self.baseColor.cgColor
    }
    
    func hideNavigationBar(controller: UIViewController) -> Void {
        controller.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setDefaultTextFieldColor(textField: UITextField) -> Void {
        textField.layer.cornerRadius = CGFloat(self.DEFAULT_CORNER_RADIUS)
        textField.layer.masksToBounds = true
        textField.layer.borderColor = self.DEFAULT_BORDER_COLOR.cgColor
        textField.layer.borderWidth = CGFloat(self.DEFAULT_BORDER_WIDTH)
    }
    
    func setDefaultTextViewColor(textView: UITextView) -> Void {
        textView.layer.cornerRadius = CGFloat(self.DEFAULT_CORNER_RADIUS)
        textView.layer.masksToBounds = true
        textView.layer.borderColor = self.DEFAULT_BORDER_COLOR.cgColor
        textView.layer.borderWidth = CGFloat(self.DEFAULT_BORDER_WIDTH)
    }

    func setTextViewStyle(textView: UITextView, label: UILabel) -> Void {
        var localLabel = label

    }
}
