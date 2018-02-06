/*
 * Utils
 * Project: Assignment 1 - Swift Slot Machine
 * Students:
 *          Mehmet Fatih Inan       300966544
 *          Kamalpreet Singh        300976062
 *          Robert Argume           300949529
 *
 * Date: Feb 05, 2018
 * Description: Class for help methods like generating sounds, etc
 * Version: 0.1
 */
import Foundation
import AVFoundation
import UIKit

class Utils {
    
    // Variable added to initialize audio in the App
    static var audioPlayer = AVAudioPlayer()
    
 
    // Play a sound from a file inside the project
    // To be reused anywhere in the App
    // From: https://stackoverflow.com/questions/43715285/xcode-swift-adding-sound-effects-to-launch-screen
    public static func playSound(file:String, ext:String) -> Void {
        do {
            let url = URL.init(fileURLWithPath: Bundle.main.path(forResource: file, ofType: ext)!)
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch let error {
            NSLog(error.localizedDescription)
        }
    }
  
}

