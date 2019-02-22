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

        var weatherURL = "https://api.openweathermap.org/data/2.5/weather?q=London&appid=6b3b6af44ecbb7a4f3c8762d43688273"
        weatherURL = weatherURL.replacingOccurrences(of: "London", with: cityName!)

        let myWeatherURL = URL (string: weatherURL)
        
        let task = URLSession.shared.dataTask(with: myWeatherURL!) {
            (data, response, error) in
            
            if error != nil {
                print(myWeatherURL)
                print("error")
            } else {
                if let urlContent = data {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                        print(jsonResult)
                        print(jsonResult["name"] as! String)
                        
                        let weather = jsonResult["weather"] as? NSArray
                        let weatherItem = weather?[0] as? NSDictionary
                        let description: String = (weatherItem?["description"] as? String)!
                        print(description)
                        self.showDetailText.text = description
                        
                    } catch {
                        print("Failed")
                    }
                }
            }
        }
        
        task.resume()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }


}
