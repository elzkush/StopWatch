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
    
    var hours: String = "00"
    var minutes: String = "00"
    var seconds: String = "00"
    
    var counter = 0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hourLabel.text = hours
        minuteLabel.text = minutes
        secondLabel.text = seconds
    }

   //MARK: Stop Button Action
    @IBAction func stopButtonTapped(_ sender: Any) {
        stopButton.isEnabled = false
        playButton.isEnabled = true
        timer.invalidate()
        reset()
    }
    
    //MARK: Pause Button Action
    @IBAction func pauseButtonTapped(_ sender: Any) {
        playButton.isEnabled = true
        pauseButton.isEnabled = false
        timer.invalidate()
    }
    
    //MARK: Play Button Action
    @IBAction func playButtonTapped(_ sender: Any) {
        playButton.isEnabled = false
        pauseButton.isEnabled = true
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(makeStep), userInfo: nil, repeats: true)
    }
    
  //logic here
    @objc func makeStep(){
        print("Seconds: \(counter)")
        if counter < 10 {
            seconds = "0\(counter)"
        } else if counter > 60 {
            seconds = "\(counter / 60)"
            minutes = "\(counter / 60 % 60)"
        }else{
            seconds = "\(counter)"
            
        }
        counter += 1
        secondLabel.text = seconds
        minuteLabel.text = minutes
    }
    
    
    func reset(){
        counter = 0
        secondLabel.text = "00"
        minuteLabel.text = "00"
        hourLabel.text = "00"
    }
    
}


