//
//  ViewController.swift
//  TriggerStop
//
//  Created by T.J. Stone on 5/4/19.
//  Copyright © 2019 T.J. Stone. All rights reserved.
//

import UIKit
import ColorSlider

class MainViewController: UIViewController {
    // Stores all of the emojis on the screen.
    var emojisInView: [UIImageView] = [UIImageView]()
    
    @IBOutlet weak var emojiButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        emojiButton.setImage(UIImage(named: "splash"), for: .normal)
        let colorSlider = ColorSlider(
            orientation: .vertical,
            previewSide: .right)
        
        colorSlider.frame = CGRect(
            x: view.frame.width * 0.1,
            y: view.frame.height * 0.2,
            width: 50,
            height: 500)
        
        view.addSubview(colorSlider)
        colorSlider.addTarget(self, action: #selector(changedColor(_:)), for: .valueChanged)
        
        let bodyImage = UIImage(named: "BlackBody")
        let bodyIV = UIImageView(image: bodyImage)
        
        bodyIV.frame = CGRect(
            x: view.frame.width * 0.2,
            y: view.frame.height * 0.1,
            width: view.frame.width * 0.75,
            height: view.frame.height * 0.75)
        view.addSubview(bodyIV)
        
    }
    
    @objc func changedColor(_ slider: ColorSlider) {
        let color = slider.color
    }
    
    /***
     Creates an Emoji Image view and adds it to the view.
     */
    @IBAction func emojiButtonPressed(_ sender: UIButton) {
        
        let newEmoji = UIImage(named: "splash")
        let emojiView = UIImageView(image: newEmoji)
        emojiView.frame.size = newEmoji!.size
        
        
        let button_x = self.emojiButton.frame.origin.x
        let button_y = self.emojiButton.frame.origin.y
        
        emojiView.frame = CGRect(
            x: button_x + 10,
            y: button_y + 10,
            width: newEmoji!.size.width,
            height: newEmoji!.size.height
        )
        
        
        let panGesture = UIPanGestureRecognizer(
            target: self,
            action:#selector(MainViewController.moveEmoji(_:)))
        
        
        emojiView.isUserInteractionEnabled = true
        emojiView.addGestureRecognizer(panGesture)
        emojisInView.append(emojiView)
        
        print("Emojies in view: \(emojisInView.count)")
        self.view.addSubview(emojiView)
    }
    
    
    var initialCenter = CGPoint()
    
    @objc func moveEmoji(_ sender: UIPanGestureRecognizer) {
        guard sender.view != nil else {return}
        let emojiView = sender.view!
        // Get the changes in the X and Y directions relative to
        // the superview's coordinate space.
        let translation = sender.translation(in: emojiView.superview)
        
        if sender.state == .began {
            // Save the view's original position.
            self.initialCenter = emojiView.center
        }
        if sender.state != .cancelled {
            // Add the X and Y translation to the view's original position.
            let newCenter = CGPoint(
                x: initialCenter.x + translation.x,
                y: initialCenter.y + translation.y)
            emojiView.center = newCenter
        }
        else {
            // On cancellation, return the piece to its original location.
            emojiView.center = initialCenter
        }
    }

}

