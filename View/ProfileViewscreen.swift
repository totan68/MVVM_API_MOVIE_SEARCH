//
//  ProfileViewscreen.swift
//  MovieSearch
//
//  Created by Totan Hazra on 10/09/24.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            // Profile Header
            ZStack {
                // Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.purple, Color.blue]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.top)
                .frame(height: 250)
                
                VStack {
                    // Profile Image
                    Image("profileImage") // Replace with your actual profile image
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 120, height: 120)
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                        .padding(.top, 80)
                    
                    // User Name
                    Text("Totan Hazra")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 1)
                    
                    // User Email
                    
                }
            }
            
            // Profile Options
            List {
                // Option 1: Edit Profile
                Button(action: {
                    print("Edit Profile tapped")
                }) {
                    HStack {
                        Image(systemName: "pencil")
                            .foregroundColor(.blue)
                        Text("Edit Profile")
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                    }
                }
                
                // Option 2: Settings
                Button(action: {
                    print("Settings tapped")
                }) {
                    HStack {
                        Image(systemName: "gear")
                            .foregroundColor(.blue)
                        Text("Settings")
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                    }
                }
                
                // Option 3: Log Out
                Button(action: {
                    print("Log Out tapped")
                }) {
                    HStack {
                        Image(systemName: "arrow.right.circle")
                            .foregroundColor(.red)
                        Text("Log Out")
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .padding(.top, -20) // Adjusts the list position to fit within the view
            
            // Back Button
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Back")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.blue)
                    .padding()
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
