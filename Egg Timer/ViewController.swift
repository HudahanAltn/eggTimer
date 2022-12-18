//
//  ViewController.swift
//  Egg Timer
//
//  Created by Hüdahan Altun on 8.10.2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

     
    @IBOutlet weak var ProgresVieww: UIProgressView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var AudioPlayerr:AVAudioPlayer = AVAudioPlayer()
    
    let EggTime:[String:Int] = ["Soft":5,"Medium":10,"Hard":15]
    
    var totalTime:Int = 0
    var secondPassed:Int = 0
    
    
    var timer:Timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProgresVieww.tintColor = .yellow
        ProgresVieww.trackTintColor = .darkGray
        ProgresVieww.progress = 0.0
        
        getVoice()//ses yükler
    }

    
    func getVoice(){
        
        do{
            
            let bundlePath = Bundle.main.path(forResource: "alarm_sound", ofType: ".mp3")
            
            AudioPlayerr =  try AVAudioPlayer(contentsOf: URL.init(filePath: bundlePath!))
            
            AudioPlayerr.prepareToPlay()
        }catch{
            
            print("ses dosyası bulunamadı!")
        }
        
        
    }
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        
        AudioPlayerr.stop()
        
        let hardness = (sender.titleLabel?.text!)! as String
        
      
        ProgresVieww.progress = 0.0
        secondPassed = 0
        titleLabel.text = "\(hardness) egg preparing..."
        totalTime = EggTime[hardness]!
       
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        
    }
    
    
    @objc func updateTimer(){
        
        if secondPassed < totalTime{
        

           
            secondPassed += 1

            let persentageeProgress:Float = Float(secondPassed) / Float(totalTime)

            print(persentageeProgress)

            ProgresVieww.progress = persentageeProgress


            
            
        }else{
            
            timer.invalidate()
            titleLabel.text = "DONE !" 
            
            AudioPlayerr.play()
        }
    }
}

