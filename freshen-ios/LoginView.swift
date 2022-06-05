//
//  LoginView.swift
//  freshen-ios
//
//  Created by Klay Anthony Clarke on 6/4/22.
//

import SwiftUI

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
					.foregroundColor(.blue)
					.font(.largeTitle)
					.bold()
					.padding()
				TextField("Email", text: $email)
					.textInputAutocapitalization(.never)
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
