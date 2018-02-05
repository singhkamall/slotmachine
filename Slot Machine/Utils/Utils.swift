/*
 * Utils.swift
 * Project: Assignment 2 - Todo List App
 * Students:
 *              Ling Bao        300901785
 *              Robert Argume   300949529
 * Date: Dec 20, 2017
 * Description:
 *              Class with useful static functions to share in the project
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

