//
//  imageFeedCell.swift
//  instagram
//
//  Created by Jasmine Farrell on 3/5/16.
//  Copyright © 2016 JIFarrell. All rights reserved.
//

import UIKit
import Parse

class imageFeedCell: UITableViewCell {
    
    @IBOutlet weak var captionLabel: UILabel!
   
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var timeStamp: UILabel!
    
    @IBOutlet weak var userImage: UIImageView!
    
    
    var pointsObject: PFObject! {
        didSet{
            point = imageFeedCell(pointObject: pointsObject!)
            point.tempCell = self;
        }
    }
    
    var point: imageFeed! {
        didSet{
            userImage.image = point.media
            captionLabel.text = point.caption
            timeStamp.text = "\(pointsObject.createdAt!)"
            userName.text = point.name
        }
    }
}
