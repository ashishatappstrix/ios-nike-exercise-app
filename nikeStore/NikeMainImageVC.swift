//
//  NikeMainImageVC.swift
//  nikeStore
//
//  Created by Ashh on 4/22/16.
//  Copyright © 2016 appstrix. All rights reserved.
//

import UIKit

class NikeMainImageVC: UIViewController {

    @IBOutlet weak var mainImg: UIImageView!
    
  
    
    var imageURL = String()
    
    
    var url = "http://images.nike.com/is/image/DotCom/NIKE_API/Nike-Dri-FIT-Touch-Fleece-Full-Zip-Mens-Training-Hoodie-644293_010.png"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Img URL \(imageURL)")
    //mainImg.imageFromUrl(imageURL)
        
        mainImg.imageFromUrl(url)
        
    }

}

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if let imageData = data as NSData? {
                    self.image = UIImage(data: imageData)
                }
            }
        }
    }
}