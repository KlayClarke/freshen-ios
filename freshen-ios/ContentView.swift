//
//  ContentView.swift
//  freshen-ios
//
//  Created by Klay Anthony Clarke on 6/3/22.
//

import SwiftUI


struct ContentView: View {
	@State private var username = ""
	@State private var password = ""
	@State private var wrongUsername = false
	@State private var wrongPassword = false
	@State private var showingLoginScreen = false
	
    var body: some View {
			NavigationView {
				ZStack {
					Color.blue.ignoresSafeArea()
					Circle()
						.scale(1.7)
						.foregroundColor(.white.opacity(0.15))
					Circle()
						.scale(1.35)
						.foregroundColor(.white)
					VStack {
						Text("Login")
							.font(.largeTitle)
							.bold()
							.padding()
						TextField("Username", text: $username)
							.disableAutocorrection(true)
							.padding()
							.frame(width: 300, height: 50)
							.background(Color.black.opacity(0.05))
							.cornerRadius(10)
							.border(.red, width: CGFloat(wrongUsername ? 2 : 0))
						SecureField("Password", text: $password)
							.padding()
							.frame(width: 300, height: 50)
							.background(Color.black.opacity(0.05))
							.cornerRadius(10)
							.border(.red, width: CGFloat(wrongPassword ? 2 : 0))
						Button("Login") {
							authenticateUser(username: username, password: password)
						}
						.foregroundColor(.white)
						.frame(width: 300, height: 50)
						.background(Color.blue)
						.cornerRadius(10)
						NavigationLink(destination: Text("You are logged in @\(username)"),isActive: $showingLoginScreen) {
							EmptyView()
						}
					}
				}
			}
			.navigationBarHidden(true)
		}
	
	func authenticateUser(username: String, password: String) {
		if username.lowercased() == "kc123" {
			wrongUsername = false
			if password.lowercased() == "password" {
				wrongPassword = false
				showingLoginScreen = true
			} else {
				wrongPassword = true
			}
		} else {
			wrongUsername = true
		}
	}
	
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
