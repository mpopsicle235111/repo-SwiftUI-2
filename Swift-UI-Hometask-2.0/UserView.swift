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
    @State private var isShowingFriendsView = false
    @State private var isShowingGroupsView = false
    //A State to control the custom Tab Bar
    @State var selectedTabBarIndex = 0
    @CamelSnaKebab(selectedCase: .Snake) var Line1 = "Hello, Jack Abramoff!"
    @CamelSnaKebab(selectedCase: .Camel) var Line2 = "Hello, Jack Abramoff!"
    @CamelSnaKebab(selectedCase: .Kebab) var Line3 = "Hello, Jack Abramoff!"
    let tabBarImageNames = ["house", "person.2.fill", "person.3", "newspaper", "eject.fill"]
    //A State to controll the full screen tile view
    @State var shouldShowModal = false
    var groups: [Group]
    var friends: [Friend]
    
    
    
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
                
                    
                NavigationLink("", destination: FriendsView(viewModel: FriendsViewModel(api: FriendsAPI())), isActive: $isShowingFriendsView)
                
                Button("Tap to see your friends") {
                    self.isShowingFriendsView = true
                }
                .foregroundColor(.black)
                .font(.body)
                //.textFieldStyle(OvalTextFieldStyle())
                .padding(.top, 5)
                .padding(.bottom, 5)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                NavigationLink("", destination: GroupsView(viewModel: GroupsViewModel(api: GroupsAPI())), isActive: $isShowingGroupsView)
                    
                Button("Tap to see your groups") {
                        self.isShowingGroupsView = true
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
                                    .navigationTitle("First Tab")
                                Image("Jack-img")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 150, alignment: .center)
                                    //Now using CamelSnaKebab package!
                                    Text(Line1)
                                        .font(.system(.body, design: .rounded))
                                        .shadow(radius: 10.0)
                                    Text(Line2)
                                    Text(Line3)
                                    
                                    Spacer()
                                }
                            }
                        //Friends Tab
                        case 1:
                            NavigationView {
                                List(friends) { friend in
                                    NavigationLink(destination: PhotoGridView()){
                                        HStack {
                                            Image(friend.imageName)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 50, height: 50, alignment: .center)
                                                VStack(alignment: .leading) {
                                                    Text(friend.name)
                                                    Text(friend.headline)
                                                        .foregroundColor(.gray)
                                                }
                                        }
                                    }
                                }
                                 .navigationTitle("Jack's friends list")
                            }
                        //Groups Tab
                        case 2:
                            List(groups) { group in
                                HStack {
                                        Image(group.imageName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50, alignment: .center)
                                        VStack(alignment: .leading) {
                                            Text(group.name)
                                            Text(group.headline)
                                                .foregroundColor(.gray)
                                        }
                                }
                            }
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
    }
}
