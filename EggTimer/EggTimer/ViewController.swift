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
    
    override func viewDidLoad() {
        timeProgress.progress = 0.0
        timeProgress.isHidden = true
    }

    var timer = Timer()
    let eggTimes: [String : Int] = ["Soft" : 3, "Medium" : 4, "Hard" : 7]
    var totalTime: Float = 0.0
    var secondsPassed: Float = 0.0
    var player: AVAudioPlayer!
    
    
    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeProgress: UIProgressView!
    
    
    // MARK: Methods and Functions
    func endTimer() {
        timer.invalidate()
    }
    
    @objc func updateTime() {
        if secondsPassed < totalTime {
        secondsPassed += 1
        timeProgress.progress = secondsPassed / totalTime
        } else {
            endTimer()
            playSound(bundle: "alarm_sound")
            titleLabel.text = "Done!"
        }
    }
    
    func playSound(bundle: String) {
        // Find file from main bundle
        let url = Bundle.main.url(forResource: bundle, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
    
    
    // MARK: Actions
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timeProgress.isHidden = false
        let hardness = sender.currentTitle!
        totalTime = Float(eggTimes[hardness]!)
        endTimer()
        titleLabel.text = hardness
        secondsPassed = 0
        timeProgress.progress = 0.0
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
    }
    
    
}
