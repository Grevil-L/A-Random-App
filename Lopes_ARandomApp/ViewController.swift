//
//  ViewController.swift
//  Lopes_ARandomApp
//
//  Created by Lopes,Grevil Gonsalo on 10/31/16.
//  Copyright © 2016 Lopes,Grevil Gonsalo. All rights reserved.
//

import UIKit

//view controller class
class ViewController: UIViewController{
    var resultsArray:[String] = [] //array to store results
    var range:String = "uint8" //range selector set to uint8
    @IBOutlet weak var arrayLengthTF: UITextField! //array length textField
    @IBOutlet weak var rangeSelectSC: UISegmentedControl! //range selector segmented control
    
    @IBOutlet weak var randomNumTV: UITextView! //text field to display values
    //used to select data type as uint8 or uint16
    @IBAction func selectRange(sender: AnyObject) {
        if rangeSelectSC.selectedSegmentIndex == 0{
            range = "uint8"
        } else {
            range = "uint16"
        }
    }
    //generating random numbers using API provided
    @IBAction func generateRandom(sender: AnyObject) {
        if arrayLengthTF.text?.characters.count > 0 {
            if Int(arrayLengthTF.text!) != nil {
                //url used to generate random numbers
                let url = NSURL(string :"https://qrng.anu.edu.au/API/jsonI.php?length=\(Int(arrayLengthTF.text!)!)&type=\(range)")
                let session = NSURLSession.sharedSession()
                session.dataTaskWithURL(url!, completionHandler: processResults).resume()
            }
        }
        
    }
    //process results function used to store numbers in array
    func processResults(data:NSData?,response:NSURLResponse?,error:NSError?)->Void {
        do {
            var jsonResult: NSDictionary?//results first stored in dictionary
            try jsonResult =  NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            
            //putting results in array if they are not nil
            if (jsonResult != nil) {
                if let results: NSArray = jsonResult!["data"] as? NSArray {
                    var test = ""
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        for r in results {
                            test += "\(r) \n"
                        }
                        self.randomNumTV.text = test
                    })
                }
            }
            
        }
        catch {
            
        }
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

