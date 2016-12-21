//
//  CustomTabBarController.swift
//  Capnote
//
//  Created by Daler Asrorov on 12/21/16.
//  Copyright © 2016 Daler Asrorov. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    private let barTintColorRGB = UIColor(red:0.90, green:0.32, blue:0.22, alpha:1.0)
    private let unselectedBarColorRGB = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
    private let selectedBarColorRGB = UIColor(red:1.00, green:0.78, blue:0.27, alpha:1.0)
    private let arrayOfImageNameForSelectedState = ["home-selected-1x", "add-selected-1x", "profile-selected-1x"]
    private let arrayOfImageNameForUnselectedState = ["home-unselected-1x", "add-unselected-1x", "profile-unselected-1x"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tab bar apperance management
        
        
        if let count = self.tabBar.items?.count {
            for i in 0...(count-1) {
                let imageNameForSelectedState   = arrayOfImageNameForSelectedState[i]
                let imageNameForUnselectedState = arrayOfImageNameForUnselectedState[i]
                
                self.tabBar.items?[i].selectedImage = UIImage(named: imageNameForSelectedState)?.withRenderingMode(.alwaysOriginal)
                self.tabBar.items?[i].image = UIImage(named: imageNameForUnselectedState)?.withRenderingMode(.alwaysOriginal)
            }
        }
        
        let selectedColor   = selectedBarColorRGB
        let unselectedColor = unselectedBarColorRGB
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: selectedColor], for: .selected)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
