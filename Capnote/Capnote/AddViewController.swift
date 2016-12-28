//
//  AddViewController.swift
//  Capnote
//
//  Created by Daler Asrorov on 12/21/16.
//  Copyright © 2016 Daler Asrorov. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UINavigationControllerDelegate,
    UIImagePickerControllerDelegate
{
    // Outlets
    @IBOutlet weak var takePhotoBtn: UIButton!
    @IBOutlet weak var uploadPhotoBtn: UIButton!
    @IBOutlet weak var imageContainerLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // Constants
    let uiService = UIServices()
    let scrollViewHeight = CGFloat(25)
    let removeImage = UIImage(named: "remove-x")
    let initialXAxisPos: CGFloat = 5.0
    
    // Variables
    var imagePicker: UIImagePickerController!
    var imageContainerWidth: CGFloat = 0.0
    var imageContainerHeight: CGFloat = 0.0
    var imageViewXAxis: CGFloat = 5.0
    var counterOfImagesUploaded = 1
    var buttonInsideImageHeight: CGFloat = 0.0
    var buttonInsideImageWidth: CGFloat = 0.0
    
    // Static variables 
    private var imagesArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCustomStyleToView()

        // Do any additional setup after loading the view.
        self.imagePicker = UIImagePickerController()
        self.imageContainerWidth = self.scrollView.frame.size.width
        self.imageContainerHeight = self.scrollView.frame.size.height
        
        // Adjust buttons inside of image constants 
        self.buttonInsideImageWidth = self.imageContainerWidth / 2
        self.buttonInsideImageHeight = self.imageContainerHeight / 2
        
    }
    
    override func viewDidLayoutSubviews() {
        self.scrollView.contentSize = CGSize (
            width: self.scrollView.contentSize.width,
            height: self.scrollViewHeight
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     * Action method handler that responds
     * to user's tap and opens camera.
     * Once the photo is taken, the token photo 
     * should appear in the view box
     */
    @IBAction func takePhoto(_ sender: Any) {

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = .camera
            present(self.imagePicker, animated: true, completion: nil)
        }
        else {
            print("The device has no camera...")
        }
        
    }
    
    /* 
     * Private method connected to the ImagePicker 
     * delegate that receives the taken photo.
     */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageIsChosen()
        
        imagePicker.dismiss(animated: true, completion: nil)
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        addChosenImageToImageContainer(image: chosenImage)
        
        self.imagesArray.append(chosenImage)
        print(self.imagesArray)
        
        print("image successfully received")
        print(chosenImage)
        
        //imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    /*
     * Action method handler that responds
     * to user's tap and opens the gallery.
     * Should allow the user to choose multiple
     * photos and show them in the view box
     */
    @IBAction func getPhotoFromLibrary(_ sender: Any) {
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.allowsEditing = false
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
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
        self.scrollView.layer.borderWidth = self.uiService.borderWidth
        self.scrollView.layer.borderColor = self.uiService.baseColorCG
    }
    
    
    func imageIsChosen() -> Bool {
        self.imageContainerLabel.text = ""
        return true
    }
    
    func addChosenImageToImageContainer(image: UIImage) {
        
        // code for image
        let newImageView = UIImageView(image: image)
        let imageViewWidth = self.imageContainerWidth / 6.68
        let imageViewHeight = self.imageContainerHeight / 1.2
        let imageViewYAxis = self.imageContainerHeight / 11.5
        
        
        
        // code for button inside of an image
        let buttonInsideImage = UIButton(type: .custom) as UIButton
        
        
        buttonInsideImage.frame = CGRect(x: 15, y: 10, width: 20, height: 20)
        buttonInsideImage.setImage(self.removeImage, for: .normal)
//        buttonInsideImage.addTarget(self, action: #selector(buttonInsideImageTouched), for: .touchUpInside)
        
        // Event hanlder for each uiimage
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(imageTapped(imgView:)))
        newImageView.isUserInteractionEnabled = true
        newImageView.addGestureRecognizer(tapGestureRecognizer)
        
        
        newImageView.frame = CGRect(x: self.imageViewXAxis, y: imageViewYAxis, width: imageViewWidth, height: imageViewHeight)
        
        if self.counterOfImagesUploaded > 5 {
          print("Here ")
          let newScrollViewSize = self.scrollView.frame.size.width + imageViewWidth + 10
          updateScrollViewSize()
        }

        // Add new components to the box
        self.scrollView.addSubview(newImageView)
        newImageView.addSubview(buttonInsideImage)
        
        self.imageViewXAxis += imageViewWidth + 5.0
        self.counterOfImagesUploaded += 1
        
        print("counterOfImagesUploaded: ", self.counterOfImagesUploaded)
    }
    
    func imageTapped(imgView: AnyObject) {
        print(":::Image tapped::: \n **Trying to remove image view.**")
        print(imgView.view!)
        
        // remove the tapped image from the view
        imgView.view!.removeFromSuperview()
        
        // 
        self.imageViewXAxis = self.initialXAxisPos
    }
    
    func buttonInsideImageTouched(sender: UIButton!) {
        print("Button was touched", sender)
    }
    
    func updateScrollViewSize() {
        var contentRect = CGRect.zero
        
        for var currentView in self.scrollView.subviews {
            contentRect = contentRect.union(currentView.frame)
        }
        
        contentRect.size.height = self.imageContainerHeight
        contentRect.size.width = contentRect.size.width + (self.scrollView.subviews[0].frame.size.width / 6.5)
        
        self.scrollView.contentSize = contentRect.size;
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
