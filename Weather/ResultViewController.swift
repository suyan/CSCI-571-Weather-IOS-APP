//
//  ResultViewController.swift
//  Weather
//
//  Created by Su Yan on 12/8/15.
//  Copyright © 2015 suyan. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, FBSDKSharingDelegate {
    
    @IBOutlet weak var summaryImage: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var upperAndLower: UILabel!
    @IBOutlet weak var percipitation: UILabel!
    @IBOutlet weak var chaneOfRain: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var dewPoint: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var visibility: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    
    var imageName = ""
    var baseSummary = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showResult()
        // fb delgate
        FBSDKApplicationDelegate.self;
    }
    
    @IBAction func facebookShare() {
        let content = FBSDKShareLinkContent()
        content.contentURL = NSURL(string: "http://forecast.io")
        content.contentTitle = summaryLabel.text
        content.contentDescription = self.baseSummary + ", " + tempLabel.text!
        content.imageURL = NSURL(string: "http://cs-server.usc.edu:45678/hw/hw8/images/\(self.imageName).png")
        
        // solution 1, use native app
        // FBSDKShareDialog.showFromViewController(self, withContent: content, delegate: self);
        // FBSDKShareDialog.showFromViewController(self, withContent: content, delegate: nil)
        
        // solution 2, use web view, without delegate
        // let button:FBSDKShareButton = FBSDKShareButton()
        // button.frame = CGRectMake(0, 0, 0, 0)
        // button.shareContent = content
        // button.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        
        // solution 3, work well without cancel
        let shareDialog: FBSDKShareDialog = FBSDKShareDialog()
        shareDialog.shareContent = content
        shareDialog.delegate = self
        shareDialog.show()
    }
    
    // Facebook Delegate Methods
    func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject: AnyObject]) {
        alertMessage("Share compeleted")
    }
    
    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!) {
        alertMessage("Share error")
    }
    
    func sharerDidCancel(sharer: FBSDKSharing!) {
        alertMessage("Share canceled")
    }
    
    func alertMessage(str: String) {
        let alert = UIAlertController(title: "Message", message: str, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func showResult () {
        var data = WeatherData.sharedInstance.data
        self.imageName = data["image_name"]! as! String
        self.baseSummary = data["base_summary"]! as! String
        summaryImage.image = UIImage(named: data["image_name"]! as! String)
        summaryLabel.text = data["summary"] as? String
        tempLabel.text = data["temp_label"] as? String
        upperAndLower.text = data["upper_and_lower"] as? String
        percipitation.text = data["percipitation"] as? String
        chaneOfRain.text = data["chance_of_rain"] as? String
        windSpeed.text = data["wind_speed"] as? String
        dewPoint.text = data["dew_point"] as? String
        humidity.text = data["humidity"] as? String
        visibility.text = data["visibility"] as? String
        sunrise.text = data["sunrise"] as? String
        sunset.text = data["sunset"] as? String
    }
}
