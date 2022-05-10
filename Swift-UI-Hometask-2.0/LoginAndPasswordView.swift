//
//  LoginAndPasswordView.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 26.04.2022.
//

import SwiftUI
import Combine

/// Custom text field style, borrowed from https://thehappyprogrammer.com/custom-textfield-in-swiftui
struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(4)  //How large the field will be, I guess padding is from the font letters
            .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(20)
            .shadow(color: .gray, radius: 2)
    }
}




struct LoginAndPasswordView: View {
    
    
        //We subscribe for two keyboard state notifiers
        private let keyboardIsOnPublisher = Publishers.Merge (
            NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
                .map { _ in true},
            NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in false}
        )
        .removeDuplicates()
    
    
       //$State marks all properties, that are responsible for the View demonstration. If anyA @State property is changed, the system knows it has to re-draw the view immediately
        @State private var loginText: String = "Admin"
        @State private var passwordText: String = "1234"
        //This var is used
        @State private var shouldShowLogo: Bool = true
        //This state checks if we need to display an alert about the wrong username/password
        @State private var shouldShowWrongPasswordWarning = false
    
        //@Binding var isUserLoggedIn: Bool
        @EnvironmentObject var appState: AppState
        
        
        
        private func checkLoginData() {
            if loginText == "Admin" && passwordText == "1234" {
                print("Access granted")
                //isUserLoggedIn = true
                appState.isUserLoggedIn = true
                
            } else {
                shouldShowWrongPasswordWarning = true
                //Clear the password for the better User eXperience (UX)
                passwordText = ""
            }
            
        }
    
        var body: some View {
            
            //Zstack allows to overlay views. Here we use it to make a background for the view.
            //We include all our Vstacks, Zstacks and buttons in Zstack,
            //so that they overlay the background image
            ZStack {
                
                Image("background1")
                    .resizable()   //Stretches the image to full screen
                //Even if the screen is rotated, the image will be adjusted
                //So far see no use in other modifiers
                
                VStack {
                    if shouldShowLogo {
                        Text("MY VK APP 3.0").fontWeight(.bold)
                            //.padding(.all) - This was used during the lesson to place the text in the screen center
                            //Set an offset from the top edge of the screen of 30 points
                            .padding(.top, 30)
                            //Set font
                            //.font(.largeTitle) - found a better modifier:
                            .font(.system(.title, design: .rounded))
                            //Set font color
                            .foregroundColor(.blue)
                    }
                    //MARK: We have wrapped two HStacks into the Scrollview
                    ScrollView {
                        
                        //This is a horizontal stack (Text + TextField will be on the same line)
                        HStack {
                            Text("Login:")
                                .padding(.leading, 10)
                                .padding(.top, 50)
                                .font(.system(.body, design: .rounded))//nice font, body stands for size type
                                .foregroundColor(.blue)
                            //This is a trick to adjust "Login" field to "Password" field:
                            //we add max distance between the text and textfield - then we set
                            //a global frame of 200 for the whole VStack
                            Spacer()
                            TextField("", text: $loginText)  //$loginText sets some placeholder text
                                //.textFieldStyle(RoundedBorderTextFieldStyle())
                                //.textFieldStyle(PlainTextFieldStyle()) - no border
                                //Let's go make an oval text field
                                .textFieldStyle(OvalTextFieldStyle())
                                .foregroundColor(.gray)
                                //Let's limit maximum width of the login field
                                .frame(maxWidth: 120)
                                .padding(.top, 50)
                                .multilineTextAlignment(.center) //nicely center the text in the field
                        }
                        
                        HStack {
                            Text("Password:")
                                .padding(.leading, 10)
                                .padding(.top, 5)
                                .padding(.bottom, 50)
                                .font(.system(.body, design: .rounded))//nice font, body stands for size type
                                .foregroundColor(.blue)
                            //This is a trick to adjust "Login" field to "Password" field:
                            //we add max distance between the text and textfield - then we set
                            //a global frame of 220 for the whole VStack
                            Spacer()
                            
                            //SecureField is the same as TextField, buth the user text will be hidden with bullets
                            TextField("", text: $passwordText)  //$passwordText sets some placeholder text
                                .textFieldStyle(OvalTextFieldStyle())
                                .foregroundColor(.gray)
                                //Let's limit maximum width of the password field
                                .frame(maxWidth: 120)
                                .padding(.top, 5)
                                .padding(.bottom, 50)
                                .multilineTextAlignment(.center) //nicely center the text in the field
                        }
                        
                        //This is an action button
                        //If password OR login is missing, the button does not work and is not highlighted
                        Button(action: checkLoginData) {
                            Text("Log in").fontWeight(.bold)
                        }
                        .disabled(loginText.isEmpty || passwordText.isEmpty)
                        .font(.body)
                        //.textFieldStyle(OvalTextFieldStyle())
                        //.foregroundColor(.white)
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                        
                        //Special button: changes depending on editing
                        EditButton()
                            .padding(.top, 60)
                        
                        //The order of the modifiers is important:
                        HStack {
                            Text("sometext1")
                                .padding(.top, 5)
                                .background(Color.red)
                            
                            Text("sometext2")
                                .background(Color.red)
                                .padding(.top, 5)
                        }
                        
                        Link(destination: URL(string : "https://proflebedev.ru")!) {
                            Text("proflebedev.ru")
                        }
                        
                        
                    }.frame(maxWidth: 220)
                    
                    //Spacer fills all the empty space and thus moves all other elements to the top
                    Spacer()
                    
                }//MARK: We have wrapped everything into the Scrollview
                //VStack ends here
                
                //If the keyboard is on (and eats the half of the screen)
                //we hide logo to have more space
                .onReceive(keyboardIsOnPublisher) {isKeyboardOn in
                    withAnimation(Animation.easeInOut(duration: 0.5)) {
                        self.shouldShowLogo = !isKeyboardOn
                    }
                }
                
            }//ZStack ends here
            .onTapGesture {
                UIApplication.shared.endEditing() //Tap screen to hide keyboard
                
            }.alert(isPresented: $shouldShowWrongPasswordWarning, content: { Alert(title: Text("Error"), message: Text("Enter a proper login and/or password"))})
                //shouldShowWrongPasswordWarning is automatically set to false after the user presses OK
         
        
        }//body ends here
        
}//LoginAndPasswordView ends here

//This extension contains a func to hide keyboard when the screen is tapped
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct LoginAndPasswordView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoginAndPasswordView()
    }
}
