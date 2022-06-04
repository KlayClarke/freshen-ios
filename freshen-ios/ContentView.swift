//
//  ContentView.swift
//  freshen-ios
//
//  Created by Klay Anthony Clarke on 6/3/22.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth


struct ContentView: View {
	@EnvironmentObject var viewModel: AppViewModel
	var body: some View {
		NavigationView {
			if viewModel.signedIn {
				VStack {
					Text("You are signed in")
					Button(action: {
						viewModel.signOut()
					}, label: {
						Text("Sign Out")
							.frame(width: 200, height: 50, alignment: .center)
							.foregroundColor(Color.blue)
					})
				}
			} else {
				LoginView()
			}
		}
		.navigationBarHidden(true)
		.onAppear(perform: {
			viewModel.signedIn = viewModel.isSignedIn
		})
	}
}


struct LoginView: View {
	@State private var email = ""
	@State private var password = ""
	@State private var wrongEmail = false
	@State private var wrongPassword = false
	@State private var showingLoginScreen = false
	@EnvironmentObject var viewModel: AppViewModel
	var body: some View {
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
				TextField("Email", text: $email)
					.textInputAutocapitalization(.none)
					.disableAutocorrection(true)
					.padding()
					.frame(width: 300, height: 50)
					.background(Color.black.opacity(0.05))
					.cornerRadius(10)
					.border(.red, width: CGFloat(wrongEmail ? 2 : 0))
				SecureField("Password", text: $password)
					.padding()
					.frame(width: 300, height: 50)
					.background(Color.black.opacity(0.05))
					.cornerRadius(10)
					.border(.red, width: CGFloat(wrongPassword ? 2 : 0))
				Button("Login") {
					guard !email.isEmpty, !password.isEmpty, !wrongEmail, !wrongPassword else {
						return
					}
					viewModel.signIn(email: email, password: password)
				}
				.foregroundColor(.white)
				.frame(width: 300, height: 50)
				.background(Color.blue)
				.cornerRadius(10)
				NavigationLink("Don't have an account? Join", destination: JoinView())
			}
		}
	}
}


struct JoinView: View {
	@State private var email = ""
	@State private var password = ""
	@State private var passwordConfirm = ""
	@State private var wrongEmail = false
	@State private var wrongPassword = false
	@State private var wrongPasswordConfirm = false
	@State private var showingLoginScreen = false
	@EnvironmentObject var viewModel: AppViewModel
	var body: some View {
		ZStack {
			Color.blue.ignoresSafeArea()
			Circle()
				.scale(1.7)
				.foregroundColor(.white.opacity(0.15))
			Circle()
				.scale(1.35)
				.foregroundColor(.white)
			VStack {
				Text("Join")
					.font(.largeTitle)
					.bold()
					.padding()
				TextField("Email", text: $email)
					.textInputAutocapitalization(.none)
					.disableAutocorrection(true)
					.padding()
					.frame(width: 300, height: 50)
					.background(Color.black.opacity(0.05))
					.cornerRadius(10)
					.border(.red, width: CGFloat(wrongEmail ? 2 : 0))
				SecureField("Password", text: $password)
					.padding()
					.frame(width: 300, height: 50)
					.background(Color.black.opacity(0.05))
					.cornerRadius(10)
					.border(.red, width: CGFloat(wrongPassword ? 2 : 0))
				SecureField("Confirm Password", text: $passwordConfirm)
					.padding()
					.frame(width: 300, height: 50)
					.background(Color.black.opacity(0.05))
					.cornerRadius(10)
					.border(.red, width: CGFloat(wrongPasswordConfirm ? 2 : 0))
				Button("Create Account") {
					guard !email.isEmpty, !password.isEmpty, !passwordConfirm.isEmpty, !wrongEmail, !wrongPassword, !wrongPasswordConfirm else {
						return
					}
					viewModel.signUp(email: email, password: password)
				}
				.foregroundColor(.white)
				.frame(width: 300, height: 50)
				.background(Color.blue)
				.cornerRadius(10)
				NavigationLink("Already have an account? Login", destination: LoginView())
			}
		}
	}
}


struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
			.environmentObject(AppViewModel())
	}
}


