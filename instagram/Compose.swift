//
//  Compose.swift
//  instagram
//
//  Created by Jasmine Farrell on 3/5/16.
//  Copyright © 2016 JIFarrell. All rights reserved.
//

import UIKit

class Compose: NSObject {
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let compose = PFObject(className: "Compose")
        
        // Add relevant fields to the object
        compose["media"] = getPFFileFromImage(image) // PFFile column type
        compose["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        compose["caption"] = caption
        compose["likesCount"] = 0
        compose["commentsCount"] = 0
        compose["name"] = PFUser.currentUser()?.username!
        
        // Save object (following function will save the object in Parse asynchronously)
        compose.saveInBackgroundWithBlock(completion)
    }
    
    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
    class func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
}

