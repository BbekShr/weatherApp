//
//  ViewController.swift
//  weatherApp
//
//  Created by Bibek Shrestha on 2/16/19.
//  Copyright © 2019 Bibek Shrestha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputCityName: UITextField!
    
    @IBOutlet weak var showDetailText: UITextView!
    
    @IBAction func submitButton(_ sender: Any) {
        var cityName = inputCityName.text
        cityName = cityName?.replacingOccurrences(of: " ", with: "-")
        
        var weatherURL = "https://www.weather-forecast.com/locations/Irving/forecasts/latest"
        weatherURL = weatherURL.replacingOccurrences(of: "Irving", with: cityName!)
    
        guard let myURL = URL(string: weatherURL) else {
            print("Error: \(weatherURL) doesn't seem to be a valid URL")
            return
        }
        
        do {
            let websiteData = try String(contentsOf: myURL)
            print(websiteData)
            var weatherStatus: [String] =  websiteData.components(separatedBy: "<span class=\"phrase\">")
            weatherStatus = weatherStatus[1].components(separatedBy:"</span>")
            weatherStatus = [weatherStatus[0].replacingOccurrences(of: "&deg;", with: " degree " )]
            showDetailText.text = weatherStatus[0]
            
        }catch _ {

            showDetailText.text = "Error Please input valid City"
            
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }


}


