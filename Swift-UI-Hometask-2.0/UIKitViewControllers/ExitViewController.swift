//
//  ExitViewController.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 05.06.2022.
//
import UIKit

import UIKit

class ExitViewController:UIViewController {

    let exitButton: UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        displayExitButton()
        exitButtonConstraints()
        
    }
    
    // Set background color to Metallica black
    override func loadView() {
        view = UIView()
        view.backgroundColor = .black
    }
    
    func exitButtonConstraints() {
        exitButton.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(exitButton)
        exitButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        exitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        exitButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50).isActive = true
    }
    
    func displayExitButton() {
        exitButton.setTitle("EXIT APPLICATION", for: .normal)
        exitButton.backgroundColor = .systemOrange
        //Set text color
        exitButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        view.addSubview(exitButton)
        //Make circular edges
        exitButton.layer.cornerRadius = 15
        //Add action
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
    }
    
    //Killswitch)))
    @objc func exitButtonTapped() {
        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
            /// Sleep for a while to let the app goes in background
            sleep(2)
            exit(0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
