/*
 * ViewController.swift
 * Project: Assignment 1 - Swift Slot Machine
 * Students:
 *          Mehmet Fatih Inan       300966544
 *          Kamalpreet Singh        300976062
 *          Robert Argume           300949529
 *
 * Date: Feb 05, 2018
 * Description: Basic Slot Machine for iOS based on "Slot Machine Code" provided on
 *              GitHub as a template
 * Version: 0.1
 */

import UIKit

class ViewController: UIViewController {
    
    // REEL IMAGES
    var reelImages: [UIImage] = [ UIImage(named: "Seven")!,
        UIImage(named: "Bar")!,
        UIImage(named: "Card")!,
        UIImage(named: "Cherry")!,
        UIImage(named: "Dunky")!,
        UIImage(named: "Lemon")!,
        UIImage(named: "Money")!,
        UIImage(named: "Penguin")!,
        UIImage(named: "Trump")!
    ]

    // OUTLETS
    @IBOutlet weak var leftReel: UIImageView!
    
    @IBOutlet weak var middleReel: UIImageView!
    
    @IBOutlet weak var rightReel: UIImageView!
    
    @IBOutlet weak var winField: UITextField!
    
    @IBOutlet weak var moneyLeftField: UITextField!
    
    @IBOutlet weak var betField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        middleReel.image = reelImages[8]
        self.view.addSubview(middleReel)
    }
    
    
    // ACTIONS
    @IBOutlet weak var onResetButtonPressed: UIButton!
    
    @IBOutlet weak var onSpinButtonPressed: UIButton!
    
}

