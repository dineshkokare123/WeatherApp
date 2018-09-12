//
//  ViewController.swift
//  WeatherApp
//
//  Created by Student P_10 on 12/09/18.
//  Copyright © 2018 priya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var SunriseTime: UILabel!
    
    
    @IBOutlet weak var Cityname: UITextField!
    

    @IBAction func SunriseTimeBtn(_ sender: UIButton) {
        
        let urlString =  "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22\(Cityname.text!)%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
        let url = NSURL(string: urlString)! as URL
       let sessionconfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionconfig)
        let dataTask =  session.dataTask(with: url) { (data, response, error) in
            
            let r = response
             if(r != nil)
            {
                let d = data
                if(d != nil)
                {
                    
                    do
                    {
                        let firstDic:[String:Any] =  try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                        
                         print("First Dic : \(firstDic)")
                        let query = firstDic["query"] as! [String:Any]
                        let results = query["results"] as! [String:Any]
                        let channel = results["channel"] as! [String:Any]
                        let astronomy = channel["astronomy"] as! [String:Any]
                        let sunrise: String =  astronomy["sunrise"] as! String
                        print(sunrise)
                        
                        DispatchQueue.main.async {
                            self.SunriseTime.text = " Sunrise time is \(astronomy["sunrise"]!)"
                            
                        }
                    
                        
                        

                    }
                    catch
                    {
                        print(error.localizedDescription)
                    }
                    
                }
                else{
                    print("data not found:\(String(describing: error?.localizedDescription))")
                    
                }
                
             }
             else
             {
                print("response not found:\(String(describing: error?.localizedDescription))")
            }
            
            
        }
        dataTask.resume()
       

        
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


