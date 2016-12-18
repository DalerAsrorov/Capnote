//
//  ImageService.swift
//  Capnote
//
//  Created by Daler Asrorov on 12/17/16.
//  Copyright © 2016 Daler Asrorov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class ImageService: NSObject {
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func formatImageView(imageView: UIImageView) {
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 10.0
    }
    
    func storeImage(image: UIImage, completion: @escaping (_ result: URL?) -> Void) {
        if UIImagePNGRepresentation(image) != nil {
            let currentImageKeyName = self.imageKeyGenerator()
            
            let storageRef = FIRStorage.storage().reference().child("images/IMG" + currentImageKeyName)
            let uploadData = UIImagePNGRepresentation(image)
            
            storageRef.put(uploadData!, metadata: nil) { (metadata, error) in
                if error != nil {
                    print("Error happened")
                    return
                }
                
                completion(metadata?.downloadURL())
            }
        }
    }
    
    func imageKeyGenerator() -> String {
        let resultKey = String(NSDate().timeIntervalSince1970) + ".png"
        return resultKey
    }

}
