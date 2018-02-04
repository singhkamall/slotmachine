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
    
    // CONSTANT FOR ANIMATING REELIMAGES
    var reelHeight:CGFloat = 0.0
    var reelOriginalY:CGFloat = 0.0
    var helperReelOriginalY:CGFloat = 0.0
    
    
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
    @IBOutlet weak var machineBackground: UIImageView!
    @IBOutlet weak var leftReel: UIImageView!
    @IBOutlet weak var helperLeftReel: UIImageView!
    
    @IBOutlet weak var middleReel: UIImageView!
    @IBOutlet weak var helperMiddleReel: UIImageView!
    
    @IBOutlet weak var rightReel: UIImageView!
    @IBOutlet weak var helperRightReel: UIImageView!
    
    @IBOutlet weak var winField: UITextField!
    
    @IBOutlet weak var moneyLeftField: UITextField!
    
    @IBOutlet weak var betField: UITextField!
    
    
    // OVERRIVEN METHODS FOR VIEW CONTROLLER
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeAnimationConstants()
        loadInitialImages()
    }
    
    
    
    // ACTIONS
    
    @IBAction func onSpinButtonPressed(_ sender: UIButton) {
        AnimateReels()
        
    }
    
    
    @IBAction func onResetButtonPressed(_ sender: UIButton) {
    }
    
    
    
    // PRIVATE FUNCTIONS
    
    // Initialize all necessary constants for animations
    private func initializeAnimationConstants() {
        // Setup position and height to be used for reel images animation
        reelHeight = leftReel.bounds.size.height
        reelOriginalY = leftReel.frame.origin.y
        helperReelOriginalY = helperLeftReel.frame.origin.y
        
        // Reels are moved to the back in relation to the other views
        
        // Two UIImageViews per Reel are used to generate the animation
        leftReel.layer.zPosition = -1
        middleReel.layer.zPosition = -1
        rightReel.layer.zPosition = -1
        
        // Helpers will have the next image to be shown in the animation
        helperLeftReel.layer.zPosition = -1
        helperMiddleReel.layer.zPosition = -1
        helperRightReel.layer.zPosition = -1
    }
    
    // This method loads two initial images. Image "7" is seen in all reels
    private func loadInitialImages() {
        middleReel.image = reelImages[0]
        self.view.addSubview(middleReel)
        leftReel.image = reelImages[0]
        self.view.addSubview(leftReel)
        rightReel.image = reelImages[0]
        self.view.addSubview(rightReel)
        
        helperMiddleReel.image = reelImages[1]
        self.view.addSubview(helperMiddleReel)
        helperLeftReel.image = reelImages[1]
        self.view.addSubview(helperLeftReel)
        helperRightReel.image = reelImages[1]
        self.view.addSubview(helperRightReel)
    }
    
    // Animates all three reels, one starts after the other with a little delay
    private func AnimateReels() {
        var yourDelay = 0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(yourDelay), execute: { () -> Void in
            self.animateReelRecursive(nextImage: 2, firstView: self.leftReel, secondView: self.helperLeftReel, duration:0.15)
        })
        
        yourDelay = 1
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(yourDelay), execute: { () -> Void in
            self.animateReelRecursive(nextImage: 2, firstView: self.middleReel, secondView: self.helperMiddleReel, duration:0.15)
        })
        
        yourDelay = 2
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(yourDelay), execute: { () -> Void in
            self.animateReelRecursive(nextImage: 2, firstView: self.rightReel, secondView: self.helperRightReel, duration:0.15)
        })
    }
   
    
    // Recursive function that make possible animation
    // Requires to receive the imageView in the correct order for the animation and the next image to be shown
    private func animateReelRecursive(nextImage:Int, firstView:UIImageView, secondView:UIImageView, duration:Double) {
        
        // Base condition to stop recursion
        // When the last image is received, it makes sure this last image is shown and end recursion
        if nextImage == reelImages.count {
            UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: {
                firstView.frame.origin.y += self.reelHeight
                secondView.frame.origin.y += self.reelHeight
            }, completion: { (success:Bool) in
                if success {
                    firstView.image = self.reelImages[0]
                    self.view.addSubview(firstView)
                    firstView.frame.origin.y = self.helperReelOriginalY
                }
            })
            return
        }
        
        // Recursive Step
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: {
            // Translate animation for both imageViews
            firstView.frame.origin.y += self.reelHeight
            secondView.frame.origin.y += self.reelHeight
        }, completion: { (success:Bool) in
            if success {
                // Then reposition one imageView to start the animation cycle, this part without animation
                firstView.image = self.reelImages[nextImage]
                self.view.addSubview(firstView)
                firstView.frame.origin.y = self.helperReelOriginalY
                
                // Recursive call to continue animation
                self.animateReelRecursive(nextImage: nextImage+1, firstView: secondView, secondView: firstView, duration: duration)
            }
        })
    }
    
}

