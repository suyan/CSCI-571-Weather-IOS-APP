//
//  ViewController.swift
//  Weather
//
//  Created by Su Yan on 12/7/15.
//  Copyright © 2015 suyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var statePicker: UIPickerView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var forecastButton: UIButton!
    @IBOutlet weak var fButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    

    let stateValues = ["Select","Alabama","Alaska","American Samoa","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","District Of Columbia","Federated States Of Micronesia","Florida","Georgia","Guam","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Marshall Islands","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Northern Mariana Islands","Ohio","Oklahoma","Oregon","Palau","Pennsylvania","Puerto Rico","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virgin Islands","Virginia","Washington","West Virginia","Wisconsin","Wyoming"]
    let stateKeys = ["NULL","AL","AK","AS","AZ","AR","CA","CO","CT","DE","DC","FM","FL","GA","GU","HI","ID","IL","IN","IA","KS","KY","LA","ME","MH","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","MP","OH","OK","OR","PW","PA","PR","RI","SC","SD","TN","TX","UT","VT","VI","VA","WA","WV","WI","WY"]
    
    var stateKey = "NULL"
    var degreeKey = "f"

    override func viewDidLoad() {
        super.viewDidLoad()

        // connect data
        self.statePicker.delegate = self
        self.streetTextField.delegate = self
        self.cityTextField.delegate = self
        self.stateTextField.delegate = self

        statePicker.hidden = true
        errorLabel.text = ""
        stateTextField.text = stateValues[0]
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
    }
    
    @IBAction func clearForms() {
        streetTextField.text = ""
        cityTextField.text = ""
        stateTextField.text = stateValues[0]
        stateKey = stateKeys[0]
        statePicker.selectRow(0, inComponent: 0, animated: true)
        errorLabel.text = ""
    }
    
    @IBAction func chooseF() {
        degreeKey = "f"
        fButton.backgroundColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        cButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        fButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), forState: UIControlState.Normal)
        cButton.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), forState: UIControlState.Normal)

    }
    
    @IBAction func chooseC() {
        degreeKey = "c"
        cButton.backgroundColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        fButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        cButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), forState: UIControlState.Normal)
        fButton.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), forState: UIControlState.Normal)
    }
    
    
    // MARK: picker delgate
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stateValues.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stateValues[row]
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        stateTextField.text = stateValues[row]
        stateKey = stateKeys[row]
        statePicker.hidden = true

    }
    
    // MARK: textfield delgate
    // when click textfield
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField == stateTextField {
            self.view.endEditing(true)
            statePicker.hidden = false
            return false
        } else {
            return true
        }
    }
    
    // when click return in keyboard, hide keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // hide keyboard when touch screen
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        streetTextField.resignFirstResponder()
        cityTextField.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    // request functions
    @IBAction func validate() {
        if streetTextField.text == "" {
            errorLabel.text = "Please input street"
        } else if cityTextField.text == "" {
            errorLabel.text = "Please input city"
        } else if stateKey == "NULL" {
            errorLabel.text = "Please select state"
        } else {
            // do request
            errorLabel.text = ""
            let street = streetTextField.text as String!
            let city = cityTextField.text as String!
            let state = stateKey
            let degree = degreeKey
            let urlString = "street=\(street)&city=\(city)&state=\(state)&degree=\(degree)&submit="
            let url = "http://csci571-suyan-env.elasticbeanstalk.com/forecast.php?" + urlString.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
            
            requestForData(url) {
                response in
                let weatherData = WeatherData.sharedInstance
                weatherData.data = weatherData.convertStringToDictionary(response)
                dispatch_async(dispatch_get_main_queue()) {
                    self.performSegueWithIdentifier("showResult", sender: self)
                }
            }
        }
    }
    
    func requestForData(url : String, callback: (response: String) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!);
        request.HTTPMethod = "GET"
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            let responseString : String = String(data: data!, encoding: NSUTF8StringEncoding)!
            callback(response: responseString)
        }
        task.resume();
    }
    
}

