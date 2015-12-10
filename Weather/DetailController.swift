//
//  DetailController.swift
//  Weather
//
//  Created by Su Yan on 12/8/15.
//  Copyright © 2015 suyan. All rights reserved.
//

import UIKit

class DetailController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var hourTableView: UITableView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var hourTab: UIButton!
    @IBOutlet weak var dayTab: UIButton!

    var hourly = true
    var hoursData = [[String]]()
    var daysData = [[String]]()
    var extraHoursData = [[String]]()
    var alreadyLoad = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hourTableView.delegate = self
        hourTableView.dataSource = self
        
        // get data from data source
        var data = WeatherData.sharedInstance.data
        let city = data["city"] as! String
        let state = data["state"] as! String
        detailLabel.text = "More Details for \(city), \(state)"
        
        let hourly = data["hourly"] as? [AnyObject]
        
        // first 12 in hoursData
        for i in 1..<13 {
            let hour = hourly![i]
            let time = hour["time"] as? String
            let image_name = hour["image_name"] as? String
            let temp = hour["temperature"] as? String
            hoursData.append([time!, image_name!, temp!])
        }
        hoursData.append(["", "plus", ""])
        
        // last 12 in extraHoursData
        for i in 13...24 {
            let hour = hourly![i]
            let time = hour["time"] as? String
            let image_name = hour["image_name"] as? String
            let temp = hour["temperature"] as? String
            extraHoursData.append([time!, image_name!, temp!])
        }
        
        let daily = data["daily"] as? [AnyObject]
        for i in 1...7 {
            let day = daily![i]
            let date = day["week_date"] as? String
            let image_name = day["image_name"] as? String
            let temp = day["temperature"] as? String
            daysData.append([date!, image_name!, temp!])
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if hourly == true {
            let cell = hourTableView.dequeueReusableCellWithIdentifier("hourCell", forIndexPath: indexPath) as! HourTableViewCell
            
            let hour = hoursData[indexPath.row]
            cell.time.text = hour[0]
            cell.summary.image = UIImage(named: hour[1])
            cell.temp.text = hour[2]
            
            return cell
        } else {
            let cell = hourTableView.dequeueReusableCellWithIdentifier("dayCell", forIndexPath: indexPath) as! DayTableViewCell
            
            let day = daysData[indexPath.row]
            cell.dateLabel.text = day[0]
            cell.summary.image = UIImage(named: day[1])
            cell.tempLabel.text = day[2]
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if hourly == true {
            return hoursData.count
        } else {
            return daysData.count
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 12 {
            if alreadyLoad == false {
                alreadyLoad = true
                hoursData.removeLast()
                for hour in extraHoursData {
                    hoursData.append(hour)
                }
                tableView.reloadData()
            }
        }
    }
    
    @IBAction func showHourly() {
        hourly = true
        hourTableView.reloadData()
        timeLabel.hidden = false
        summaryLabel.hidden = false
        tempLabel.hidden = false
        hourTab.backgroundColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        dayTab.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        hourTab.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), forState: UIControlState.Normal)
        dayTab.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), forState: UIControlState.Normal)
    }
    
    @IBAction func showDaily() {
        hourly = false
        hourTableView.reloadData()
        timeLabel.hidden = true
        summaryLabel.hidden = true
        tempLabel.hidden = true
        dayTab.backgroundColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        hourTab.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        dayTab.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), forState: UIControlState.Normal)
        hourTab.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), forState: UIControlState.Normal)
        
    }
    
    
}
