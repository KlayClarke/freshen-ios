//
//  freshen_iosApp.swift
//  freshen-ios
//
//  Created by Klay Anthony Clarke on 6/3/22.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

class AppViewModel: ObservableObject {
	
	let auth = Auth.auth()
	
	@Published var signedIn = false
	var isSignedIn: Bool {
		return auth.currentUser != nil
	}
	
	func signIn(email: String, password: String) {
		auth.signIn(withEmail: email, password: password) {[weak self] result, error in
			guard result != nil, error == nil else {
				return
			}
			// successfully signed in user
			DispatchQueue.main.async {
				self?.signedIn = true
			}
		}
	}
	
	func signUp(email: String, password: String) {
		auth.createUser(withEmail: email, password: password) {[weak self] result, error in
			guard result != nil, error == nil else {
				return
			}
			// successfully created user && signed in after creation
			DispatchQueue.main.async {
				self?.signedIn = true
			}
		}
	}
	
	func signOut() {
		try? auth.signOut()
		self.signedIn = false
	}
}


class AppDelegate: NSObject, UIApplicationDelegate {
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		FirebaseApp.configure()
		return true
	}
}

@main
struct freshen_iosApp: App {
	// register app delegate for Firebase Setup
	@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
					let viewModel = AppViewModel()
            ContentView()
						.environmentObject(viewModel)
        }
    }
}
