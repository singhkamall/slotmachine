//
//  ViewController.swift
//  Slot Machine
//
//  Created by Kamalpreet Singh on 2018-01-29.
//  Copyright © 2018 SlotMachine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var leftReel: UIImageView!
    
    @IBOutlet weak var middleReel: UIImageView!
    
    @IBOutlet weak var rightReel: UIImageView!
    
    @IBOutlet weak var winField: UITextField!
    
    @IBOutlet weak var moneyLeftField: UITextField!
    
    @IBOutlet weak var betField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var onResetButtonPressed: UIButton!
    
    @IBOutlet weak var onSpinButtonPressed: UIButton!
    
}

