//
//  SignUpViewController.swift
//  Capnote
//
//  Created by Daler Asrorov on 12/16/16.
//  Copyright © 2016 Daler Asrorov. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var newUsernameTF: UITextField!
    @IBOutlet weak var newEmailTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var newMajorTF: UITextField!
    @IBOutlet weak var newSchoolNameTF: UITextField!
    @IBOutlet weak var newProfileImageUV: UIImageView!
    
    // declare constants
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up delegates for UITextField variables 
        setUpDelegates()

        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(imageTapped(img:)))
        newProfileImageUV.isUserInteractionEnabled = true
        newProfileImageUV.addGestureRecognizer(tapGestureRecognizer)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpUser(_ sender: Any) {
        if newUsernameTF.text == "" || newEmailTF.text == "" || newEmailTF.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Enter all required credentials!", preferredStyle: UIAlertControllerStyle.alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
        
    }
    
    /*
    * Action handler after the user taps on the UIImageView.
    * It should generate UIImagePickerView
    */
    func imageTapped(img: AnyObject)
    {
        print("Something happened")
    }
    
    /**
     * Called when 'return' key pressed. return NO to ignore.
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /**
     * Called when the user click on the view (outside the UITextField).
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setUpDelegates() {
        newEmailTF.delegate = self
        newUsernameTF.delegate = self
        newMajorTF.delegate = self
        newPasswordTF.delegate = self
        newSchoolNameTF.delegate = self
        
        // UIImagePickerView
        imagePicker.delegate = self
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
