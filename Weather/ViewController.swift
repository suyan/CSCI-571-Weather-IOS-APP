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
    @IBOutlet weak var degreeTextField: UITextField!
    @IBOutlet weak var degreePicker: UIPickerView!
    @IBOutlet weak var errorLabel: UILabel!

    let stateValues = ["Select","Alabama","Alaska","American Samoa","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","District Of Columbia","Federated States Of Micronesia","Florida","Georgia","Guam","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Marshall Islands","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Northern Mariana Islands","Ohio","Oklahoma","Oregon","Palau","Pennsylvania","Puerto Rico","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virgin Islands","Virginia","Washington","West Virginia","Wisconsin","Wyoming"]
    let stateKeys = ["NULL","AL","AK","AS","AZ","AR","CA","CO","CT","DE","DC","FM","FL","GA","GU","HI","ID","IL","IN","IA","KS","KY","LA","ME","MH","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","MP","OH","OK","OR","PW","PA","PR","RI","SC","SD","TN","TX","UT","VT","VI","VA","WA","WV","WI","WY"]
    let degreeValues = ["Fahrenheit", "Celsius"]
    let degreeKeys = ["f", "c"]
    
    var stateKey = "NULL"
    var degreeKey = "f"

    override func viewDidLoad() {
        super.viewDidLoad()

        // connect data
        self.statePicker.delegate = self
        self.degreePicker.delegate = self
        self.streetTextField.delegate = self
        self.cityTextField.delegate = self
        self.stateTextField.delegate = self
        self.degreeTextField.delegate = self

        statePicker.hidden = true
        degreePicker.hidden = true
        errorLabel.text = ""
        stateTextField.text = stateValues[0]
        degreeTextField.text = degreeValues[0]
    }
    
    @IBAction func clearForms() {
        streetTextField.text = ""
        cityTextField.text = ""
        stateTextField.text = stateValues[0]
        stateKey = stateKeys[0]
        statePicker.selectRow(0, inComponent: 0, animated: true)
        degreeTextField.text = degreeValues[0]
        degreeKey = degreeKeys[0]
        degreePicker.selectRow(0, inComponent: 0, animated: true)
        errorLabel.text = ""
    }
    
    // MARK: picker delgate
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == statePicker {
            return stateValues.count
        } else {
            return degreeValues.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == statePicker {
            return stateValues[row]
        } else {
            return degreeValues[row]
        }
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == statePicker {
            stateTextField.text = stateValues[row]
            stateKey = stateKeys[row]
            statePicker.hidden = true
        } else {
            degreeTextField.text = degreeValues[row]
            degreeKey = degreeKeys[row]
            degreePicker.hidden = true
        }
    }
    
    // MARK: textfield delgate
    // when click textfield
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField == degreeTextField {
            self.view.endEditing(true)
            statePicker.hidden = true
            degreePicker.hidden = false
            return false
        } else if textField == stateTextField {
            self.view.endEditing(true)
            degreePicker.hidden = true
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
    
    // MARK: segue delgate
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "doSearch" {
            if streetTextField.text == "" {
                errorLabel.text = "Please input street"
                return false
            } else if cityTextField.text == "" {
                errorLabel.text = "Please input city"
                return false
            } else if stateKey == "NULL" {
                errorLabel.text = "Please select state"
                return false
            } else {
                errorLabel.text = ""
                // do request
            }
        }
        return true
    }
}

