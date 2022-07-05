//
//  ViewController.swift
//  StopWatch
//
//  Created by Elzada Kushbakova on 16/6/22.
//

import UIKit

class ViewController: UIViewController {
        
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var slider: UISlider!
    
    var hours: String = "00"
    var minutes: String = "00"
    var seconds: String = "00"
    
    var counterHours: Int = 0
    var counterMinutes: Int = 0
    var counterSeconds: Int = 0
    
    var isTimer: Bool = false
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        slider.isHidden = true
        hourLabel.text = hours
        minuteLabel.text = minutes
        secondLabel.text = seconds
    }
    
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        secondLabel.text = "\(Int(sender.value))"
        counterSeconds = Int(sender.value)
    }
    
    func buttonState(play: Bool = true, pause: Bool = true, stop: Bool = true){
        playButton.isEnabled = play
        pauseButton.isEnabled = pause
        stopButton.isEnabled = stop
        
    }
    
    
    @IBAction func segmentedTapped(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex{
        case 0:
            timer.invalidate()
            reset()
            
            buttonState(pause: false, stop: false)
            
            isTimer = false
            view.backgroundColor = .lightGray
            slider.isHidden = true
        case 1:
            isTimer = true
            timer.invalidate()
            reset()
            
            buttonState(pause: false, stop: false)
            
            view.backgroundColor = .darkGray
            slider.isHidden = false
        default:
            print("Hello")
        }
    }
    

   //MARK: Stop Button Action
    @IBAction func stopButtonTapped(_ sender: Any) {
        buttonState(pause: false, stop: false)
        timer.invalidate()
        reset()
    }
    
    //MARK: Pause Button Action
    @IBAction func pauseButtonTapped(_ sender: Any) {
        buttonState(pause: false)
        timer.invalidate()
    }
    
    //MARK: Play Button Action
    @IBAction func playButtonTapped(_ sender: Any) {
        buttonState(play: false)
        
        if isTimer{
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(makeStepBack), userInfo: nil, repeats: true)
        } else {
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(makeStep), userInfo: nil, repeats: true)
        }
    }
    
  //logic here
    
    
    @objc func makeStepBack(){
        if counterSeconds != 0{
            secondLabel.text = "\(counterSeconds)"
            counterSeconds -= 1
            slider.value = Float(counterSeconds)
        }else{
            buttonState(pause: false, stop: false)
            reset()
            timer.invalidate()
        }
    }
    
    @objc func makeStep(){
        secondAddZero()
        counterSeconds += 1
        secondLabel.text = seconds
        
        if counterSeconds > 59{
            counterSeconds = 0
            counterMinutes += 1
            minutesAddZero()
            minuteLabel.text = minutes
            if counterMinutes > 59 {
                counterMinutes = 0
                counterHours += 1
                hoursAddZero()
                hourLabel.text = hours
                if counterHours > 59{
                    reset()
                }
            }
        }
    }

    func reset(){
        counterSeconds = 0
        counterMinutes = 0
        counterHours = 0
        
        secondLabel.text = "00"
        minuteLabel.text = "00"
        hourLabel.text = "00"
        
        if isTimer {
            slider.value = 0
        }
    }
    
    func secondAddZero(){
        if counterSeconds < 10 {
            seconds = "0\(counterSeconds)"
        }else{
            seconds = "\(counterSeconds)"
        }
    }
    
    func minutesAddZero(){
        if counterMinutes < 10 {
            minutes = "0\(counterMinutes)"
        }else{
            minutes = "\(counterMinutes)"
        }
    }
    func hoursAddZero(){
        if counterSeconds < 10 {
            hours = "0\(counterHours)"
        }else{
            hours = "\(counterHours)"
        }
    }
}


