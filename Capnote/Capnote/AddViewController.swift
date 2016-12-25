//
//  AddViewController.swift
//  Capnote
//
//  Created by Daler Asrorov on 12/21/16.
//  Copyright © 2016 Daler Asrorov. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var takePhotoBtn: UIButton!
    @IBOutlet weak var uploadPhotoBtn: UIButton!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var imageContainerLabel: UILabel!
    
    // Constants
    let uiService = UIServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCustomStyleToView()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadCustomStyleToView() {
        // Adding border radius to buttons
        self.takePhotoBtn.layer.cornerRadius = self.uiService.buttonRoundRadius
        self.uploadPhotoBtn.layer.cornerRadius = self.uiService.buttonRoundRadius
        
        // Adding border width and its color
        self.takePhotoBtn.layer.borderWidth = self.uiService.borderWidth
        self.uploadPhotoBtn.layer.borderWidth = self.uiService.borderWidth
        self.takePhotoBtn.layer.borderColor = self.uiService.baseColorCG
        self.uploadPhotoBtn.layer.borderColor = self.uiService.baseColorCG
        
        // Adding style to the image container
        self.imageContainerView.layer.borderWidth = self.uiService.borderWidth
        self.imageContainerView.layer.borderColor = self.uiService.baseColorCG
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
