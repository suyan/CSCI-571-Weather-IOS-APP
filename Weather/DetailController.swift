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

    var hourly = true
    var hoursData = [[String]]()
    var daysData = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hourTableView.delegate = self
        hourTableView.dataSource = self
        // get data from data source
        var data = WeatherData.sharedInstance.data
        let hourly = data["hourly"] as? [AnyObject]
        for hour in hourly! {
            let time = hour["time"] as? String
            let image_name = hour["image_name"] as? String
            let temp = hour["temperature"] as? String
            hoursData.append([time!, image_name!, temp!])
        }
        let daily = data["daily"] as? [AnyObject]
        for day in daily! {
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
    
    @IBAction func showHourly() {
        hourly = true
        hourTableView.reloadData()
        timeLabel.hidden = false
        summaryLabel.hidden = false
        tempLabel.hidden = false
    }
    
    @IBAction func showDaily() {
        hourly = false
        hourTableView.reloadData()
        timeLabel.hidden = true
        summaryLabel.hidden = true
        tempLabel.hidden = true
    }
    
    
}
