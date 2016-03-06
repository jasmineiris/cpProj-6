//
//  imageFeed.swift
//  instagram
//
//  Created by Jasmine Farrell on 3/5/16.
//  Copyright © 2016 JIFarrell. All rights reserved.
//

import UIKit

class imageFeed: NSObject {
    var media: UIImage?
    var author: PFUser?
    var caption: String?
    var likesCount: Int?
    var commentsCount: Int?
    var name: String?
    var tempCell: imageFeedCell?
    
    init(pointObject: PFObject) {
        super.init()
        tempCell = PointInTimeCell()
        print("This is it \(pointObject)")
        caption = pointObject["caption"] as? String
        //tempCell!.captionLabel.text = caption
        likesCount = pointObject["likesCount"] as? Int
        commentsCount = pointObject["commentsCount"] as? Int
        author = pointObject["author"] as! PFUser?
        name = pointObject["name"] as? String
        
        if let userPicture = pointObject.valueForKey("media")! as? PFFile {
            userPicture.getDataInBackgroundWithBlock({
                (imageData: NSData?, error: NSError?) -> Void in
                if (error == nil) {
                    let image = UIImage(data:imageData!)
                    self.tempCell!.pointInTime.image = image
                    self.media = image
                    //self.pointInTime.sizeToFit()
                    print("picture loaded")
                }
            })
        }
    }
    
}
