//
//  UserView.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 27.04.2022.
//  Navigation as per Paul Hudson: https://youtu.be/nA6Jo6YnL9g
//  Custom tab bar by Brian Voong: https://youtu.be/9lVLFlyaiq4

import SwiftUI
import CamelSnaKebabPackage

struct UserView: View {
    @EnvironmentObject var appState: AppState
    //@State private var isShowingFriendsView = false
    //@State private var isShowingGroupsView = false
    @State private var isShowingPhotosView = false
    //A State to control the custom Tab Bar
    @State var selectedTabBarIndex = 0
    @CamelSnaKebab(selectedCase: .Snake) var Line1 = "CSK Library Test Snake: Hello, Jack Abramoff!"
    @CamelSnaKebab(selectedCase: .Camel) var Line2 = "CSK Library Test Camel: Hello, Jack Abramoff!"
    @CamelSnaKebab(selectedCase: .Kebab) var Line3 = "CSK Library Test Kebab: Hello_Jack Abramoff!"
    let tabBarImageNames = ["house", "person.2.fill", "person.3", "newspaper", "eject.fill"]
    //A State to controll the full screen tile view
    @State var shouldShowModal = false
    var groups: [Group]
    var friends: [Friend]
    
    
    //Add this line when you remove hardcoded groups and friends
    //to use user's own data for PhotosView
    //@ObservedObject var viewModel: PhotosViewModel
    
    //If you remove hardcoded groups and friends, you will be able to use user;s own data for Photos View
    //init(viewModel: PhotosViewModel) {
    //self.viewModel = viewModel
    //}
    
    //This is used to fix the Xcode 12.3 bug when the tab bar has yellow background color by default. YOu can set it to .systemBackground
    //or .white
//    init() {
//        UITabBar.appearance().barTintColor = .systemBackground
//        UINavigationBar.appearance().barTintColor = .systemBackground
//    }
    
    //var groups: [Group]
    
    var body: some View {
        NavigationView {
            VStack {
                
                //A link to user's own photos, maybe make a special Tab for them?
                //MARK: use hardcoded User id 693292969 instead of
                //id: Int(Session.shared.userId) ?? 0
                //TO DO: push user's values into this init, like it works for friends. Just remove hardcoded friends and groups and properly initialize the ViewModel (see above).
                NavigationLink("", destination: PhotosView(viewModel: PhotosViewModel(friend: FriendAPI.init(canAccessClosed: false, domain: "", city: nil, id: Int(Session.shared.userId) ?? 0, photo100: "Jack-img", lastName: "\"Your own photos, ", photo50: "", trackCode: "", isClosed: false, firstName: "Jack Abramoff...\""), api: PhotosAPI())), isActive: $isShowingPhotosView)
                    
                Button("Tap to see your photos") {
                        self.isShowingPhotosView = true
                }
                .foregroundColor(.black)
                .font(.body)
                .padding(.top, 5)
                .padding(.bottom, 5)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                
                
                
                //We replicate the native TabBar behavior Using VStack
                //(Thanks to Brian Voong)
                //Spacing: 0 is used to remove a small gap between the Divider and the view
                VStack(spacing: 0) {
                    
                    ZStack {
                        
                        //This is for full-screen tile images view
                        Spacer()
                            .fullScreenCover(isPresented: $shouldShowModal, content: {
                                //A button to return back to TabView
                                FriendsView(viewModel: FriendsViewModel(api: FriendsAPI()))
                                Button(action: {shouldShowModal.toggle()}, label: {
                                Text("GO BACK")
                                })
                        })
                        
                        switch selectedTabBarIndex {
                        //main User Page
                        case 0:
                            NavigationView {
                                VStack {
                                Text("Home")
                                    .navigationTitle("")
                                Image("Jack-img")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 150, alignment: .center)
                                    //Now using CamelSnaKebab package!
                                    Text(Line1)
                                        .font(.system(.footnote, design: .rounded))
                                        .shadow(radius: 10.0)
                                    Text(Line2)
                                        .font(.system(.footnote, design: .rounded))
                                    Text(Line3)
                                        .font(.system(.footnote, design: .rounded))
                                    
                                    Spacer()
                                }
                            }
                        //Friends Tab
                        case 1:
                            FriendsView(viewModel: FriendsViewModel(api: FriendsAPI()))
                                .navigationBarTitle("Friends", displayMode: .automatic)
                                 
                        //Groups Tab
                        case 2:
                            GroupsView(viewModel: GroupsViewModel(api: GroupsAPI()))
                                .navigationBarTitle("Groups", displayMode: .automatic)
                        //News Tab
                        case 3:
                            ScrollView {
                                
                            }
                        default:
                            VStack {
                                Text("Exit")
                                Spacer()
                                Button("Exit App") {
                                                    appState.isUserLoggedIn = false
                                    }
                                    .foregroundColor(.blue)
                                    .font(.body)
                                    .padding(.top, 10)
                                    .padding(.bottom, 10)
                                    .padding(.leading, 20)
                                    .padding(.trailing, 20)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                Spacer()
                            }
                        }
                    
                    }
                
                    //Spacer()
                    
                    //Nice gray line to separate the buttons
                    Divider()
                        .padding(.bottom, 10)
                    HStack {
                        ForEach(0..<5) { num in
                            Button(action: {
                                
                                //Let's try the fullscreen tile view
                                //On NEWS tab
                                if num == 3 {
                                    shouldShowModal.toggle()
                                    return
                                }
                                
                                selectedTabBarIndex = num
                            }, label: {
                                Spacer()
                                
                                //Let's make exit button red)))
                                if num == 4 {
                                    Image(systemName: tabBarImageNames[num])
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(.red)
                                } else {
                                    Image(systemName: tabBarImageNames[num])
                                        .font(.system(size: 24, weight: .bold))
                                        //Blue for selected, gray otherwise
                                        //.foregroundColor(selectedTabBarIndex == num ? Color(.systemBlue) : .gray)
                                        //Or use shades:
                                        .foregroundColor(selectedTabBarIndex == num ? Color(.systemBlue) : .init(white: 0.8))
                                }
                                Spacer()
                            })
                            
                        }
                    }
                    
                    
                }
                
                
            } //VStack ends here
            .navigationBarTitle("The Main Page", displayMode: .inline)
           
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(groups: groupsData, friends: friendsData)
        //Add PhotosViewModel here when you remove hardcoded friends and groups. See "PhotosView" for details
    }
}
