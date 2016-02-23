//
//  ViewController.swift
//  JSONdata
//
//  Created by Dustin M on 2/22/16.
//  Copyright © 2016 Vento. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    
    @IBOutlet var findMeButtonLabel: UIButton!

    @IBOutlet var ipLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var regionLabel: UILabel!
    @IBOutlet var zipLabel: UILabel!
    
    @IBOutlet var map: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func findMeButtonPressed(sender: AnyObject) {
    
        let url = NSURL(string:"https://freegeoip.net/json/")!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            
            if let urlContent = data {
                
                do {
                    
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    
                    print(jsonResult["city"])

                    
                  
                    
                    /*
                    self.ipLabel.text =
                    self.countryLabel.text =
                    self.cityLabel.text = 
                    self.regionLabel.text = 
                    self.zipLabel.text =

                    
                    var latitude: CLLocationDegrees = jsonResult(["latitude"])
                    var longitude: CLLocationDegrees = jsonResult(["longitude"])
                    var latDelta: CLLocationDegrees = 0.01
                    var lonDelta: CLLocationDegrees = 0.01
                    var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
                    var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                    var region: MKCoordinateRegion = MKCoordinateRegionMake(location,span)
                    self.map.setRegion(region, animated: true)
                    */
                    
                    
                    
                } catch {
                    
                    print("JSON Serialization failed")
                    self.findMeButtonLabel.setTitle("Try Again", forState: .Normal)
                    
                }
                
            }
            
            
        }
        
        task.resume()
    
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

