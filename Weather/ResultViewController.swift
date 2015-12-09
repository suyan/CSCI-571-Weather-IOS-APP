//
//  ResultViewController.swift
//  Weather
//
//  Created by Su Yan on 12/8/15.
//  Copyright © 2015 suyan. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var data = WeatherData.sharedInstance.data
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
