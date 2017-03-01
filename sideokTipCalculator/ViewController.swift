//
//  ViewController.swift
//  sideokTipCalculator
//
//  Created by Sideok You on 3/1/17.
//  Copyright © 2017 Sideok You. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var firstView: UIView!
    @IBOutlet weak var eachTipLabel: UILabel!
    @IBOutlet weak var totalTipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var defaultTipLabel: UILabel!
    @IBOutlet weak var defaultNOPLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear in tipCalculator")
        
        self.firstView.alpha = 0
        UIView.animate(withDuration: 0.6, animations:{
            self.firstView.alpha = 1
        })
        /*
         sending any object here because it doesn't matter
         it could be sending tip rate or number of people as a parameter.
         Whenver this view calls, it calls tipCalculator so that user always can see changed value
        */
        tipCalculator("hi" as AnyObject)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear in tipCalculator")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear in tipCalculator")
        
        //Animation added when this view moves to different view.
        self.firstView.alpha = 1
        UIView.animate(withDuration: 0.6, animations: {
            self.firstView.alpha = 0;
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear in tipCalculator")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated.
    }

    @IBAction func tipCalculator(_ sender: AnyObject) {
        //This function is for calculating tip and total.
        
        //Animation added
        self.firstView.alpha = 1
        UIView.animate(withDuration: 0.3, animations: {
            self.firstView.alpha = 0.7
        })
        UIView.animate(withDuration: 0.3, animations: {
            self.firstView.alpha = 1
        })
        
        //Get the value of bill input
        let bill = Double(billField.text!) ?? 0
        
        //It gets tip rate from setting page.
        let defaultTipRate = UserDefaults.standard
        let tipRate = defaultTipRate.double(forKey: "tipRate")
        
        //It gets number of people from setting page.
        let defaultNumberOfPeople = UserDefaults.standard
        let numberOfPeople = defaultNumberOfPeople.double(forKey: "numberOfPeople")
        
        //Set initial value for realNOP and realTR
        var realNOP = 1.0
        var realTR = 0.1
        
        //Error handling when tipRate can be zero.
        if(tipRate != 0.0){
            realTR = tipRate
            defaultTipLabel.text = String(format:"%.f%%", realTR*100)
        }else{
            defaultTipLabel.text = "10%"
        }
        
        //Error handling when numberOfPeople can be zero.
        if(numberOfPeople != 0.0){
            realNOP = numberOfPeople
            defaultNOPLabel.text = String(format: "%.f", realNOP)
        }else{
            defaultNOPLabel.text = "1"
        }
        
        //Calculating tip, and it needs to prevent when realTR is 0, so I set the initial value as 10%
        let tip = bill * realTR
        //Calculating tip for each person, and it needs to prevent when realNOP is 0. any number cannot be divided by zero.
        let eachtip = tip / realNOP
        //Calculating tip and bill together.
        let total = bill + tip
        
        //Set value to the view.
        eachTipLabel.text = String(format:"$%.2f", eachtip)
        totalTipLabel.text = String(format:"$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
    }

    @IBAction func onTap(_ sender: AnyObject) {
        //Whenver an user touchs any space except textfield, it will be closing the keyboard.
        view.endEditing(true);
    }
}

