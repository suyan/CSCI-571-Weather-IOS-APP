//
//  MapViewController.swift
//  Weather
//
//  Created by Su Yan on 12/9/15.
//  Copyright © 2015 suyan. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let aerisConsumerId = "gL9ybmDKr7Y3qpXnWf0zG"
        let aerisConsumerSecret = "ddR4vvON2htEqVRanhxmxCZeLUvrZkJ28GNveOpx"
        AerisEngine.engineWithKey(aerisConsumerId, secret: aerisConsumerSecret)
        
        let weatherMap:AWFWeatherMap = AWFWeatherMap.init(mapType: AWFWeatherMapType.Apple)
        weatherMap.weatherMapView.frame = self.view.bounds

        var data = WeatherData.sharedInstance.data
        let lat = data["lat"] as! Double
        let lon = data["lon"] as! Double
        let position = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
        weatherMap.setMapCenterCoordinate(position, zoomLevel: UInt(10), animated: false)
        weatherMap.addLayerType(AWFLayerType.RadarSatellite)

        self.view.addSubview(weatherMap.weatherMapView)
        // you can later add layer by weather.addLayerType()
    }
}
