//
//  LoginViewController.swift
//  Capnote
//
//  Created by Daler Asrorov on 12/15/16.
//  Copyright © 2016 Daler Asrorov. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    private let segueIdentifier: String = "loginSegue"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDelegates()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginUser(_ sender: Any) {
        if usernameTF.text == "" || passTF.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            let inputEmail = self.usernameTF.text!
            let inputPassword = self.passTF.text!
            
            FIRAuth.auth()?.signIn(withEmail: inputEmail, password: inputPassword, completion: { (user, error) in
                if error == nil {
                    // models & services
                    let userServices = UserServices()
                    let userModel = UserModel()
                    
                    print(user?.displayName ?? "dfsfds")
                    print(user?.email ?? "dffds")
                    print("Logged in successfully. ")
                    
                    //                    userServices.gerUserDataDict()
                    
                    userModel.setToLocalStorage(completion: { (dict, username) in
                        userServices.storeUserInfoToLocalStorage(userDict: dict, username: username)
                    })
                    
                    self.performSegue(withIdentifier: self.segueIdentifier, sender: self)
                    
                }
                else {
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            })
        }
    }
    
    @IBAction func registerUser(_ sender: Any) {
        
    }
    
    
    func setUpDelegates() {
        usernameTF.delegate = self
        passTF.delegate = self
    }
    
    /**
     * Called when the user click on the view (outside the UITextField).
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /**
     * Called when 'return' key pressed. return NO to ignore.
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
