//
//  ViewController.swift
//  BullsEye
//
//  Created by Aimoré Sá on 17.11.15.
//  Copyright © 2015 Aimoré Sá. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // declare Interface builders
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var  targetLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var roundLabel: UILabel!
    
    // declare variables
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // start a new round and update the labels
        startNewGame()
        updateLabels()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, forState: .Normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        if let trackLeftImage = UIImage(named: "SliderTrackLeft") {
            
            let trackLeftResizable =
            trackLeftImage.resizableImageWithCapInsets(insets)
            slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        }
        if let trackRightImage = UIImage(named: "SliderTrackRight") {
            
            let trackRightResizable =
            trackRightImage.resizableImageWithCapInsets(insets)
            slider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        }
        else if difference < 5 {
            title = "Almost there!"
            points += 50
        }
        else if difference < 10 {
            title = "Not bad!"
        }
        else {
            title = "Not even close..."
        }
        
        score += points
        
        let message = "The value of the slider is: \(currentValue)" +
        "\nThe Target value is: \(targetValue)" +
        "\nYou scored \(points) points"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "OK", style: .Default,
            handler: {
            action in self.startNewRound()
            self.updateLabels()
            })
        
        alert.addAction(action)
        
        //make the alert visible
        presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(slider: UISlider) {
        
       currentValue = lroundf(slider.value)
       
    }
    
    @IBAction func startOver() {
        startNewGame()
        updateLabels()
    }
    
    func startNewRound() {
        
        round += 1
        
        targetValue = 1 + Int(arc4random_uniform(100))
        
        currentValue = 0
        
        slider.value = Float(currentValue)
        
    }
    
    func startNewGame(){
        score = 0
        round = 0
        startNewRound()
    }
    
    func updateLabels() {
        
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
        
        
    }

}

