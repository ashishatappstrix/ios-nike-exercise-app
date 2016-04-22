//
//  NikeProduct.swift
//  nikeStore
//
//  Created by Phalu Yadlapati on 4/22/16.
//  Copyright © 2016 appstrix. All rights reserved.
//

import Foundation
import Alamofire


class NikeProduct {
    
    var name: String!
    var color: String!
    var price: Double!
    var imageURL: String!
    var thumbImageURL: String!
    var image: NSData! {
        get {
            return imageFromUrl(imageURL)
        }
    }
    var thumbImage: NSData! {
        get {
            return imageFromUrl(thumbImageURL)
        }
    }
    
     func imageFromUrl(urlString: String) -> NSData? {
        var image: NSData!
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if let imageData = data as NSData? {
                    image = imageData
                }
            }
        }
        
        return image
    }
    
 }