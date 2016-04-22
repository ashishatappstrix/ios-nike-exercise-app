//
//  ViewController.swift
//  nikeStore
//
//  Created by Ashh on 4/22/16.
//  Copyright © 2016 appstrix. All rights reserved.
//

import UIKit
import Alamofire

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var nikeProductsTableView: UITableView!
    
    var products = [NikeProduct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nikeProductsTableView.dataSource = self
        nikeProductsTableView.delegate = self

        downloadProductDetails()
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = nikeProductsTableView.dequeueReusableCellWithIdentifier("cell",forIndexPath: indexPath) as! NikeProductTableViewCell

        cell.configureCell(products[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 100.0
    }
    
     func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.contentView.backgroundColor = UIColor.clearColor()
        
        let whiteRoundedView : UIView = UIView(frame: CGRectMake(0, 10, self.view.frame.size.width, 120))
        
        whiteRoundedView.layer.backgroundColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), [1.0, 1.0, 1.0, 1.0])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0
        whiteRoundedView.layer.shadowOffset = CGSizeMake(-1, 1)
        whiteRoundedView.layer.shadowOpacity = 0.2
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubviewToBack(whiteRoundedView)
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let product = products[indexPath.row]
       
        performSegueWithIdentifier("NikeMainImageVC", sender: product)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "NikeMainImageVC" {
            if let detailVC = segue.destinationViewController as? NikeMainImageVC {
                if let product = sender as? NikeProduct {
                           //print("\(product.imageURL)")
                    detailVC.imageURL = product.imageURL
             
                }
            }
        }
    }
    
    func downloadProductDetails() {
        
        let url = NSURL(string: URL)!
        
        Alamofire.request(.GET, url).responseJSON { response in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let results = dict["results"] as? [Dictionary<String, AnyObject>] {
                    
                    
                    for result in results {
                        
                        let nikeProduct = NikeProduct()
                        
                    if let name1 = result["name1"] as? String {
                        
                        nikeProduct.name = name1
                    }
                        
                        if let prices = result["prices"] as? Dictionary<String, AnyObject> {
      
                            if let price = prices["list"] as? String {
                                
                                nikeProduct.price = Double(price)
                                
                                print("Price: \(price)")
                            }

                        }
                        
                        if let colorDescription = result["colorDescription"] as? String {
                            
                            nikeProduct.color = colorDescription
                        }
                    
                        if let images = result["images"] as? [Dictionary<String, AnyObject>] {
                            
                            for image in images {
                                
                                if let full = image["full"] as? String {
                                    
                                    nikeProduct.imageURL = full
                                }
                                
                                if let thumb = image["thumb"] as? String {
                                    
                                    nikeProduct.thumbImageURL = thumb

                                }
                            }
                        }
                        
                        self.products.append(nikeProduct)
                        
                    }
                    
                }
                
            }
            self.nikeProductsTableView.reloadData();
            
        }
    }
    
}

