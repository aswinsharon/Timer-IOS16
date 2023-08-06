//
//  ViewController.swift
//  eggTimer
//
//  Created by Aswin Sharon on 05/08/23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
     
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var counter:Int? = nil
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer!
    var eggTimes:[String?:Int?] = [
                                  "Soft":10,
                                  "Medium":11,
                                  "Hard":12
                               ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0.0
    }
    
    func playSound() {
           let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
           player = try! AVAudioPlayer(contentsOf: url!)
           player!.play()
       }

    @objc func updateCounter() {
        if secondsPassed <= totalTime {
            let percentageProgress = Float(secondsPassed)/Float(totalTime)
            print(percentageProgress)
            progressBar.progress = percentageProgress
            secondsPassed += 1
        }else{
            timer.invalidate()
            playSound()
            statusText.text = "🥳 Done 🥳"
        }
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!!
        progressBar.progress = 0.0
        secondsPassed = 0
        statusText.text = hardness
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
}

