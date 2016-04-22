//
//  NikeProductTableViewCell.swift
//  nikeStore
//
//  Created by Ashh on 4/22/16.
//  Copyright © 2016 appstrix. All rights reserved.
//

import UIKit

class NikeProductTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var color: UILabel!
    @IBOutlet weak var price: UILabel!
    
    var nikeProduct: NikeProduct!
    
    func configureCell(product: NikeProduct) {
        self.nikeProduct = product;
        name.text = self.nikeProduct.name
        color.text = self.nikeProduct.color
        price.text = "$ \(self.nikeProduct.price)"
        thumbImage.downloadedFrom(link: self.nikeProduct.thumbImageURL, contentMode: .ScaleAspectFill);
        
    }

}

extension UIImageView {
    func downloadedFrom(link link:String, contentMode mode: UIViewContentMode) {
        guard
            let url = NSURL(string: link)
            else {return}
        contentMode = mode
        NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            guard
                let httpURLResponse = response as? NSHTTPURLResponse where httpURLResponse.statusCode == 200,
                let mimeType = response?.MIMEType where mimeType.hasPrefix("image"),
                let data = data where error == nil,
                let image = UIImage(data: data)
                else { return }
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.image = image
            }
        }).resume()
    }
}