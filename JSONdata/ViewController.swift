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
                    
                    //print(jsonResult)
                    print ("response:\(jsonResult)")
                    
                    
                    // this gets back the main thread which is the UI thread
                    // if you try to update the UI thread from a background thread (which you are in right now, you would get errors
                    let queue = dispatch_get_main_queue()
                    dispatch_async(queue, { () -> Void in
                        
                        if let ip = jsonResult["ip"] as? String {
                            self.ipLabel.text = ip
                        }
                        
                        if let country = jsonResult["country_code"] as? String {
                            self.countryLabel.text = country
                        }
                        
                        if let city = jsonResult["city"] as? String {
                            self.cityLabel.text = city
                        }
                        
                        if let region = jsonResult["region_name"] as? String {
                            self.regionLabel.text = region
                        }
                        
                        if let zip = jsonResult["zip_code"] as? String {
                            self.zipLabel.text = zip
                        }
                        
                        
                        if let latitudeData = jsonResult["latitude"] as? Double {
                            let latitude: CLLocationDegrees = latitudeData
                           
                            if let longitudeData = jsonResult["longitude"] as? Double {
                                let longitude: CLLocationDegrees = longitudeData
                                
                                let latDelta: CLLocationDegrees = 0.01
                                let lonDelta: CLLocationDegrees = 0.01
                                let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
                                let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                                let region: MKCoordinateRegion = MKCoordinateRegionMake(location,span)
                                self.map.setRegion(region, animated: true)
                                
                                let annotation = MKPointAnnotation()
                                annotation.coordinate = location
                                annotation.title = "Your IP"
                                annotation.subtitle = "is somewhere around here"
                                self.map.addAnnotation(annotation)
                                
                            }
                            
                        }
                        
                        
                    })

                    
                } catch {
                    
                    self.findMeButtonLabel.setTitle("Try Again", forState: .Normal)
                    print("JSON Serialization failed")
                    
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

