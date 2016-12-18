//
//  SignUpViewController.swift
//  Capnote
//
//  Created by Daler Asrorov on 12/16/16.
//  Copyright © 2016 Daler Asrorov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class SignUpViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Outlets and components
    @IBOutlet weak var newUsernameTF: UITextField!
    @IBOutlet weak var newEmailTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var newMajorTF: UITextField!
    @IBOutlet weak var newSchoolNameTF: UITextField!
    @IBOutlet weak var newProfileImageUV: UIImageView!
    
    // private instance variables
    private var latestSelectedImage: UIImage!
    var imageContainer = [UIImage]()
    
    // declare constants
    let imagePicker = UIImagePickerController()
    let imageService = ImageService()
    
    // models
    let userModel = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up delegates for UITextField variables 
        setUpDelegates()
        setUpLastThingsForView()

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
        if newUsernameTF.text == "" || newPasswordTF.text == "" || newEmailTF.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Enter all required credentials!", preferredStyle: UIAlertControllerStyle.alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
        else {
            let inputEmail = self.newEmailTF.text!
            let inputPassword = self.newPasswordTF.text!
            
            imageService.storeImage(image: self.newProfileImageUV.image!, completion: { (url) in
                FIRAuth.auth()?.createUser(withEmail: inputEmail, password: inputPassword, completion: { (user, error) in
                    if error == nil {
                        let inputUsername = self.newUsernameTF.text!
                        let inputSchool = self.newSchoolNameTF.text!
                        let inputMajor = self.newMajorTF.text!
                        let inputImageURL = url?.absoluteString
                        
                        self.userModel.addUser(username: inputUsername, email: inputEmail, school: inputSchool, major: inputMajor, imageURL: inputImageURL!)
                        
                        print(inputUsername + " signed up successfully!")
                    }
                    else {
                        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                })
            })
            
  
        }
        
    }
    
    /*
    *   Action handler after the user taps on the UIImageView.
    *   It should generate UIImagePickerView
    */
    func imageTapped(img: AnyObject)
    {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .savedPhotosAlbum
        
        present(imagePicker, animated: true, completion: nil)
        print("Something happened")
    }
    
    /*
     *  Load image into the view and store it
     *  in an array for further handling
     */
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageContainer.removeAll()
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let resizedImage = imageService.resizeImage(image: pickedImage, targetSize: CGSize(width: 140, height: 140))
            newProfileImageUV.image = resizedImage
            self.latestSelectedImage = resizedImage
            imageContainer.append(resizedImage)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
    
    func setUpLastThingsForView() {
        imageService.formatImageView(imageView: newProfileImageUV)
    }
    
    func deregisterFromKeyboardNotifications(){
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
