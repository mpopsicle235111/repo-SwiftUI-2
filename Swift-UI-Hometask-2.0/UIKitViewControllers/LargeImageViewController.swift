//
//  LargeImageViewController.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 05.06.2022.
//

import UIKit

/// This is the class,that handles the large images
class LargeImageViewController: UIViewController {
    
    //This adds gesture recognizer from the LargeImageView
    //Was pulled in here as ACTION (not OUTLET)
    //and UIPANGESTURERECOGNIZER, not ANY
    //Actually you can apply PanGestureRicognizer
    //To any specific View - i.e. you can apply it to the
    //picture, but bot to the controls, etc.
    //Main thing - it works on the separate basis, not
    //the whle screen automatically, so yu can select areas where
    //recognition works, and the areas outside that view won't trigger the recognizer
    @IBAction func panView(_ sender: UIPanGestureRecognizer) {
        //imageView is our photograph's View
        //It was let card = sender.view!
        //But guard let's us avoid ugly forcing
        print("did tap image view", sender)
        guard let imageView = sender.view else {return}
        //Translation in math means, that we move object, but change nothing in it
        //So we touch at point and move
        //And the translation tracks how much we have mover the finger
        let point = sender.translation(in: viewCanvas)
        
        //To move image we need to change it's center property
        //CGPoint contains just X and Y values for our screen
        //So we get to CGPoint a new X and a new Y for the center
        imageView.center = CGPoint(x: viewCanvas.center.x + point.x, y: viewCanvas.center.y + point.y)
        
        if sender.state == UIGestureRecognizer.State.ended {
            
            //Return image back to center position after we toyed with it
            UIView.animate(withDuration: 0.2, animations: {
                imageView.center = self.viewCanvas.center
            })
        }
    }
    
    
    
    
    @IBOutlet weak var viewCanvas: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        navigationItem.title = "Photo"
        
        
    }
    
    
    
    var interactiveAnimator: UIViewPropertyAnimator!
    
    //onPan is called on ANY user gesture
    /// Some method for some actions blah-blah-blah
    /// - Parameter recognizer: IDK that's for sure
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began: //as soon as any gesture happens,
            //we create animation that lowers the view 20 down
            //even if the user moves to the left/right - the
            //View goes down
            interactiveAnimator = UIViewPropertyAnimator(
                duration: 0.5,
                curve: .easeInOut,
                animations: {self.imageView.frame = self.imageView.frame.offsetBy(dx: 0, dy: 20)}
            )
            //after each touch the animation has to be paused
            interactiveAnimator.pauseAnimation()
            
        case .changed: //As soon as the finger coordinate changes,
            //the strength of the gesture is measured.
            //The stronger the gesture - the bigger
            //fraction of it will be used
            let translation = recognizer.translation(in: self.view)
            interactiveAnimator.fractionComplete = translation.y / 100
            
        case .ended: //If the gesture is over (the finger is lifted),
            //we stop the animation
            interactiveAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            interactiveAnimator.stopAnimation(false) //Freeze
            //and check
            //if it is necessary to call completion and finish animation
            interactiveAnimator.finishAnimation(at: .end) //Total finish
        default: return
        }
    }
    
}

