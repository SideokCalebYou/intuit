//
//  SettingsViewController.swift
//  sideokTipCalculator
//
//  Created by Sideok You on 3/1/17.
//  Copyright © 2017 Sideok You. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var secondView: UIView!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var peopleControl: UISegmentedControl!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear in Settings")
        /*
         Since I wanted to show what user selected, I used UserDefaults again for showing user's selected value.
         */
        self.secondView.alpha = 0
        UIView.animate(withDuration: 0.6, animations: {
            self.secondView.alpha = 1
        })
        
        //This is for tip
        let selectedTipIndex = UserDefaults.standard
        let getTipIndex = selectedTipIndex.integer(forKey: "selectedTipRateIndex")
        
        //It needed for handling initial phase because the value can be zero.
        if(getTipIndex == 0){
            tipControl.selectedSegmentIndex = 0
        }else{
            tipControl.selectedSegmentIndex = getTipIndex
            
        }
        
        //This is for number of people
        let selectedNumberOfPeopleIndex = UserDefaults.standard
        let getNumberOfPeopleIndex = selectedNumberOfPeopleIndex.integer(forKey:"selectedNumberOfPeopleIndex")
        
        //It needed for handling initial phase because the value can be zero.
        if(getNumberOfPeopleIndex == 0){
            peopleControl.selectedSegmentIndex = 0
        }else{
            peopleControl.selectedSegmentIndex = getNumberOfPeopleIndex
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear in Settings")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear in Settings")
        
        //Animation added when it goes to different view from this view.
        self.secondView.alpha = 1
        UIView.animate(withDuration: 0.6, animations: {
            self.secondView.alpha = 0
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear in Settings")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setTip(_ sender: AnyObject) {
        //This function is for setting tip rate.
        
        let tipPercentage = [0.1, 0.12, 0.15, 0.18, 0.2]
        
        //This is for showing selected value
        let selectedRateIndex = UserDefaults.standard
        selectedRateIndex.set(tipControl.selectedSegmentIndex, forKey: "selectedTipRateIndex")
        selectedRateIndex.synchronize()
        
        //Stored tip percentage which user selected
        let defaultTipRate = UserDefaults.standard
        defaultTipRate.set(tipPercentage[tipControl.selectedSegmentIndex], forKey: "tipRate")
        defaultTipRate.synchronize()
    }

    @IBAction func SetPeople(_ sender: Any) {
        //This function is for setting number of people
        
        let howMany = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0]
        
        //This is for showing selected value
        let selectedNumberOfPeopleIndex = UserDefaults.standard
        selectedNumberOfPeopleIndex.set(peopleControl.selectedSegmentIndex, forKey:"selectedNumberOfPeopleIndex")
        selectedNumberOfPeopleIndex.synchronize()
        
        //Stored number of people which user selected.
        let defaultNumberOfPeople = UserDefaults.standard
        defaultNumberOfPeople.set(howMany[peopleControl.selectedSegmentIndex], forKey:"numberOfPeople")
        defaultNumberOfPeople.synchronize()
    }
}
