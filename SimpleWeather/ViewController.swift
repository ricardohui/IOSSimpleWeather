//
//  ViewController.swift
//  SimpleWeather
//
//  Created by Ricardo Hui on 3/3/2019.
//  Copyright © 2019 Ricardo Hui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func submit(_ sender: Any) {
    }
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let url = URL(string: "https://www.weather-forecast.com/locations/\(textField.text!.replacingOccurrences(of: " ", with: "-"))/forecasts/latest"){
        let request = NSMutableURLRequest(url:url)
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            var message = ""
            if let error = error {
                print(error)
            }else{
                if let unwrappedData = data{
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                    var stringSeparator = "Weather Forecast Summary: </b><span class=\"read-more-small\"><span class\"read-more-content\"><span class=\"phrase\">"
                    if let contentArray = dataString?.components(separatedBy: stringSeparator){
                        print(contentArray)
                        if contentArray.count > 1{
                            stringSeparator = "</span>"
                          let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                                if newContentArray.count > 1 {
                                    message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "\"")
                                    print(message)
                                }
                        
                        }
                    }
                    
                    
                }
            }
            if message == ""{
                message  = "The weather there couldnt be found. Please try again."
            }
            DispatchQueue.main.sync(execute:{
                self.resultLabel.text = message
            })
            
        }
        task.resume()
        }else{
             resultLabel.text  = "The weather there couldnt be found. Please try again."
        }
       
        
    }


}

