//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let eggTimes = ["Soft":3, "Medium":4, "Hard":7] // 300, 420, 720
    
    var totalTime: Float = 0.0
    var secondsPassed: Float = 0.0
    var player: AVAudioPlayer!
    var timer = Timer()
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var eggProgress: UIProgressView!
    
        
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        totalTime = 0.0
        secondsPassed = 0.0
        eggProgress.progress = 0.0
        let hardness = sender.currentTitle!
        
        totalTime = Float(eggTimes[hardness]!)
        titleLabel.text = hardness
        
        eggProgress.isHidden = false
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        
    }
    
    

    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
    
    @objc func updateTimer(){
        if secondsPassed < totalTime{
            secondsPassed += 1
            let percentageProgress = secondsPassed / totalTime
            eggProgress.progress = percentageProgress
            
            
            
        } else {
            timer.invalidate()
            playSound(soundName: "alarm_sound")
            titleLabel.text = "Done !"
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                self.eggProgress.isHidden = true
                self.titleLabel.text = "How do you like your eggs?"
            }
        }
        
    }
    
}
    
    

    


