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
//    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var imageContainerLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // Constants
    let uiService = UIServices()
    let scrollViewHeight = CGFloat(25)
    
    // Variables
    var imagePicker: UIImagePickerController!
    var imageContainerWidth: CGFloat = 0.0
    var imageContainerHeight: CGFloat = 0.0
    var imageViewXAxis: CGFloat = 5.0
    var counterOfImagesUploaded = 1
    
    // Static variables 
    private var imagesArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCustomStyleToView()

        // Do any additional setup after loading the view.
        self.imagePicker = UIImagePickerController()
        self.imageContainerWidth = self.scrollView.frame.size.width
        self.imageContainerHeight = self.scrollView.frame.size.height
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
        let newImageView = UIImageView(image: image)
        let imageViewWidth = self.imageContainerWidth / 6.68
        let imageViewHeight = self.imageContainerHeight / 1.2
        let imageViewYAxis = self.imageContainerHeight / 11.5
        
        newImageView.frame = CGRect(x: self.imageViewXAxis, y: imageViewYAxis, width: imageViewWidth, height: imageViewHeight)
        //self.imageContainerView.addSubview(newImageView)
        
        if self.counterOfImagesUploaded > 5 {
          print("Here ")
          let newScrollViewSize = self.scrollView.frame.size.width + imageViewWidth + 10
            print("newScrollViewSize: ", newScrollViewSize)
          // self.scrollView.frame.size.width = 2000
          // self.scrollView.frame.size = CGSize(width: 2000, height: self.scrollView.frame.size.height)
          updateScrollViewSize()
        }

        self.scrollView.addSubview(newImageView)
        
        self.imageViewXAxis += imageViewWidth + 5.0
        self.counterOfImagesUploaded += 1
        
        print("counterOfImagesUploaded: ", self.counterOfImagesUploaded)
    }
    
    func updateScrollViewSize() {
        var contentRect = CGRect.zero
        
        for var currentView in self.scrollView.subviews {
            contentRect = contentRect.union(currentView.frame)
        }
        
        print("THE SIZE SHOULD BE HERE")
        contentRect.size.height = self.imageContainerHeight
        contentRect.size.width = contentRect.size.width + (self.scrollView.subviews[0].frame.size.width / 6.5)
        print(self.scrollView.subviews[0].frame.size.width)
        
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
