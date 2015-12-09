//
//  WeatherData.swift
//  Weather
//
//  Created by Su Yan on 12/8/15.
//  Copyright © 2015 suyan. All rights reserved.
//

import Foundation

class WeatherData {

    class var sharedInstance: WeatherData {
        struct Static {
            static var instance: WeatherData?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = WeatherData()
        }
        
        return Static.instance!
    }
    
    var data : [String:AnyObject]!

    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
}