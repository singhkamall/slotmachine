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
    
    // VARIABLE
    var playerMoney: Int = 1000;
    var winnings: Int = 0;
    var jackpot: Int = 5000;
    var turn: Int = 0;
    var playerBet: Int = 0;
    var winNumber: Int = 0;
    var lossNumber: Int = 0;
    var spinResult: [String] = [];
    var fruits: String = "";
    var winRatio: Int = 0;
    var seven: Int = 0;
    var bars: Int = 0;
    var card: Int = 0;
    var cherries: Int = 0;
    var dunky: Int = 0;
    var lemon: Int = 0;
    var money: Int = 0;
    var penguin: Int = 0;
    var trump: Int = 0;
    
    // CONSTANT FOR ANIMATING REELIMAGES
    var reelHeight:CGFloat = 0.0
    var reelOriginalY:CGFloat = 0.0
    var helperReelOriginalY:CGFloat = 0.0
    
    
    // REEL IMAGES
    var reelImages: [UIImage] = [
        UIImage(named: "Seven")!,
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
    @IBOutlet weak var lblWinLose: UILabel!
    @IBOutlet weak var tvJackpot: UITextView!
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
        //AnimateReels()
        
        playerBet =  Int(betField.text!)!
        
        if (playerMoney == 0)
        {
            let alertController = UIAlertController(title: "Alert", message: "You ran out of Money! \nDo you want to play again?", preferredStyle: .alert)
        
            // Create OK button
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                
                // Code in this block will trigger when OK button tapped.
                self.ResetAll()
                self.showPlayerStats()
                
            }
            alertController.addAction(OKAction)
            
            // Create Cancel button
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            }
            alertController.addAction(cancelAction)
            
            // Present Dialog message
            self.present(alertController, animated: true, completion:nil)
            
        }
        else if (playerBet > playerMoney) {
            //alert("You don't have enough Money to place that bet.");
            let alertController = UIAlertController(title: "Alert", message: "You don't have enough Money to place that bet.", preferredStyle: .alert)
            
            // Create OK button
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            }
            alertController.addAction(OKAction)
            
            // Present Dialog message
            self.present(alertController, animated: true, completion:nil)
        }
        else if (playerBet < 0) {
            //alert("All bets must be a positive $ amount.");
            let alertController = UIAlertController(title: "Alert", message: "All bets must be a positive $ amount.", preferredStyle: .alert)
            
            // Create OK button
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            }
            alertController.addAction(OKAction)
            
            // Present Dialog message
            self.present(alertController, animated: true, completion:nil)
        }
        else if (playerBet <= playerMoney) {
            spinResult = Reels();
            fruits = spinResult[0] + " - " + spinResult[1] + " - " + spinResult[2];
            lblWinLose.text = fruits
            //$("div#result>p").text(fruits);
            determineWinnings();
            turn += 1;
            showPlayerStats();
        }
        else {
            //alert("Please enter a valid bet amount");
            let alertController = UIAlertController(title: "Alert", message: "APlease enter a valid bet amount", preferredStyle: .alert)
            
            // Create OK button
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            }
            alertController.addAction(OKAction)
            
            // Present Dialog message
            self.present(alertController, animated: true, completion:nil)
        }
        
    }
    
    
    @IBAction func onResetButtonPressed(_ sender: UIButton) {
        ResetReel()
    }
    
    func showPlayerStats()
    {
        winRatio = winNumber / turn;
        tvJackpot.text = String(jackpot)
        
        moneyLeftField.text = (String(playerMoney))
        winField.text = (String(winNumber))
        
        //$("#playerTurn").text("Turn: " + turn);
        //$("#playerWins").text("Wins: " + winNumber);
        //$("#playerLosses").text("Losses: " + lossNumber);
        //$("#playerWinRatio").text("Win Ratio: " + (winRatio * 100).toFixed(2) + "%");
    }
    
    func ResetReel() {
        seven = 0
        bars = 0
        card = 0
        cherries = 0
        dunky = 0
        lemon = 0
        money = 0
        penguin = 0
        trump = 0
    }
    
    func ResetAll() {
        playerMoney = 1000
        winnings = 0
        jackpot = 5000
        turn = 0
        playerBet = 0
        winNumber = 0
        lossNumber = 0
        winRatio = 0
    }
    
    func checkJackPot() {
        /* compare two random values */
        var jackPotTry = roundf(Float(drand48() * 51.0 + 1.0));
        var jackPotWin = roundf(Float(drand48() * 51.0 + 1.0));
        if (jackPotTry == jackPotWin) {
            
            //alert("You Won the $" + jackpot + " Jackpot!!");
            let alert = UIAlertController(title: "Congratualtion!!", message: "You Won the $" + String(jackpot) + " Jackpot!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true)
            
            playerMoney += jackpot
            jackpot = 1000
        }
    }
    
    func showWinMessage() {
        playerMoney += winnings
        lblWinLose.text = "You Won: $" + String(winnings)
        
        //$("div#winOrLose>p").text("You Won: $" + winnings);
        
        ResetReel()
        checkJackPot()
    }
    
    func showLossMessage() {
        playerMoney -= playerBet;
        lblWinLose.text = "You Lost!"
        
        //$("div#winOrLose>p").text("You Lost!");
        
        ResetReel()
    }

    func checkRange(value: Float, lowerBounds: Int, upperBounds: Int) -> Float {
        if (value >= Float(lowerBounds) && value <= Float(upperBounds))
        {
            return value;
        }
        else {
            return value;   //////////// CANNOT ADD ! HERE as -> !value
        }
    }
    
    func Reels() -> [String] {
        var betLine: [String] = [" ", " ", " "];
        var outCome = [0, 0, 0];
    
        for spin in 0...2 {
            outCome[spin] = Int(roundf(Float(drand48() * 65) + 1))
            switch (Float(outCome[spin])) {
                case checkRange(value: Float(outCome[spin]), lowerBounds: 1, upperBounds: 27):  // 41.5% probability
                    betLine[spin] = "trump"
                    trump += 1
                break;
            case checkRange(value: Float(outCome[spin]), lowerBounds: 28, upperBounds: 37): // 15.4% probability
                    betLine[spin] = "seven"
                    seven += 1
                break;
            case checkRange(value: Float(outCome[spin]), lowerBounds: 38, upperBounds: 46): // 13.8% probability
                    betLine[spin] = "bars"
                    bars += 1
                break;
            case checkRange(value: Float(outCome[spin]), lowerBounds: 47, upperBounds: 54): // 12.3% probability
                    betLine[spin] = "card";
                    card += 1;
                break;
            case checkRange(value: Float(outCome[spin]), lowerBounds: 55, upperBounds: 59): //  7.7% probability
                    betLine[spin] = "cherries";
                    cherries += 1;
                break;
            case checkRange(value: Float(outCome[spin]), lowerBounds: 60, upperBounds: 62): //  4.6% probability
                    betLine[spin] = "dunky";
                    dunky += 1;
                break;
            case checkRange(value: Float(outCome[spin]), lowerBounds: 63, upperBounds: 64): //  3.1% probability
                    betLine[spin] = "lemon";
                    lemon += 1;
                break;
            case checkRange(value: Float(outCome[spin]), lowerBounds: 65, upperBounds: 65): //  1.5% probability
                    betLine[spin] = "money";
                    money += 1;
                break;
            default: break
                
            }
        }
        return betLine;
    }
    
    func determineWinnings()
    {
        if (trump == 0)
        {
            if (seven == 3) {
                winnings = playerBet * 10;
            }
            else if(bars == 3) {
                winnings = playerBet * 20;
            }
            else if (card == 3) {
                winnings = playerBet * 30;
            }
            else if (cherries == 3) {
                winnings = playerBet * 40;
            }
            else if (bars == 3) {
                winnings = playerBet * 50;
            }
            else if (lemon == 3) {
                winnings = playerBet * 75;
            }
            else if (penguin == 3) {
                winnings = playerBet * 100;
            }
            else if (seven == 2) {
                winnings = playerBet * 2;
            }
            else if (bars == 2) {
                winnings = playerBet * 2;
            }
            else if (card == 2) {
                winnings = playerBet * 3;
            }
            else if (cherries == 2) {
                winnings = playerBet * 4;
            }
            else if (bars == 2) {
                winnings = playerBet * 5;
            }
            else if (lemon == 2) {
                winnings = playerBet * 10;
            }
            else if (penguin == 2) {
                winnings = playerBet * 20;
            }
            else if (penguin == 1) {
                winnings = playerBet * 5;
            }
            else {
                winnings = playerBet * 1;
            }
            winNumber += 1;
            showWinMessage();
        }
        else
        {
            lossNumber += 1;
            showLossMessage();
        }
    
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

