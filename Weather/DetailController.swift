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
    var hoursData = [
        ["time1", "summary1", "temp1"],
        ["time2", "summary2", "temp2"],
        ["time3", "summary3", "temp3"]
    ]
    var daysData = [
        ["date1", "summary1", "temp1"],
        ["date2", "summary2", "temp2"],
        ["date3", "summary3", "temp3"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hourTableView.delegate = self
        hourTableView.dataSource = self
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if hourly == true {
            let cell = hourTableView.dequeueReusableCellWithIdentifier("hourCell", forIndexPath: indexPath) as! HourTableViewCell
            
            let hour = hoursData[indexPath.row]
            cell.time.text = hour[0]
            cell.summary.image = UIImage(named: "clear")
            cell.temp.text = hour[2]
            
            return cell
        } else {
            let cell = hourTableView.dequeueReusableCellWithIdentifier("dayCell", forIndexPath: indexPath) as! DayTableViewCell
            
            let day = daysData[indexPath.row]
            cell.dateLabel.text = day[0]
            cell.summary.image = UIImage(named: "clear")
            cell.tempLabel.text = day[2]
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hoursData.count
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
