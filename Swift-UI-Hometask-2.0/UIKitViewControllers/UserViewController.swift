//
//  UserViewController.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 05.06.2022.
//
//  UITextField Programmatically by LearnEDU
//  https://youtu.be/CgJuJpOnNuc
//
//  UIButton programmatically by Coding Tutor
//  https://youtu.be/iLumM3X3Yu8
//
//  NavigationController with code by iOS Academy
//  https://youtu.be/Ime8NK5NLgc



import UIKit

class UserViewController:UIViewController {

    let userName: UITextField = UITextField(frame: CGRect(x: 10, y: 320, width: 150, height: 30))
    let userPassword: UITextField = UITextField(frame: CGRect(x: 10, y: 360, width: 150, height: 30))
    
    
    let userImageView: UIImageView = {
           let theImageView = UIImageView()
           theImageView.image = UIImage(named: "Jack-img")
           theImageView.translatesAutoresizingMaskIntoConstraints = false //You need to call this property so the image is added to your view
           return theImageView
        }()
    
    let button: UIButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(userImageView) //This add it the view controller without constraints
        userImageViewConstraints() //This function is outside the viewDidLoad function that controls the constraints
        displayLoginFields()
        displayButton()
        buttonConstraints()
        userNameConstraints()
        userPasswordConstraints()
    }
    
    // Set background color to Metallica black
    override func loadView() {
        view = UIView()
        view.backgroundColor = .black
    }
    
    // do not forget the `.isActive = true` after every constraint
    func userImageViewConstraints() {
        userImageView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        userImageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        userImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
    }
    
    func userNameConstraints() {
        userName.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(userName)
        userName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userName.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30).isActive = true
        userName.widthAnchor.constraint(equalToConstant: 180).isActive = true
    }
    
    func userPasswordConstraints() {
        userPassword.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(userPassword)
        userPassword.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userPassword.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80).isActive = true
        userPassword.widthAnchor.constraint(equalToConstant: 180).isActive = true
    }
    
    func buttonConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(button)
        button.widthAnchor.constraint(equalToConstant: 250).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150).isActive = true
    }
    
    func displayLoginFields() {
        userName.placeholder = "Jack Abramoff"
        userName.borderStyle = UITextField.BorderStyle.line
        userName.backgroundColor = UIColor.white
        userName.textColor = UIColor.black
        userName.textAlignment = .center
        // Add UITextField as a subview
        self.view.addSubview(userName)
        // Set UITextField placeholder text
        userPassword.placeholder = "password"
        userPassword.textAlignment = .center
        userPassword.isSecureTextEntry = true
        // Set UITextField border style
        userPassword.borderStyle = UITextField.BorderStyle.line
        // Set UITextField background colour
        userPassword.backgroundColor = UIColor.white
        // Set UITextField text color
        userPassword.textColor = UIColor.black
        // Add UITextField as a subview
        self.view.addSubview(userPassword)
    }
    
    func displayButton() {
        button.setTitle("See Jack's photos", for: .normal)
        button.backgroundColor = .systemOrange
        //Set text color
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        view.addSubview(button)
        //Make circular edges
        button.layer.cornerRadius = 15
        //Add action
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc func buttonTapped() {
        let destination = UserPhotoCollectionViewController(api: PhotosAPI())
         //destination.friend = self.friend
         show(destination, sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


