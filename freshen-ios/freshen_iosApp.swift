//
//  freshen_iosApp.swift
//  freshen-ios
//
//  Created by Klay Anthony Clarke on 6/3/22.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class AppViewModel: ObservableObject {
	
	let auth = Auth.auth()
	let db = Firestore.firestore()
	
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
	
	func signUp(displayName: String, email: String, password: String) {
		auth.createUser(withEmail: email, password: password) {[weak self] result, error in
			guard result != nil, error == nil else {
				return
			}
			// save user display name to db and link via uid or email
			self?.db.collection("users").document(result!.user.uid).setData([
				"displayName": displayName
			]) { err in
				if let err = err {
					print("Error writing document: \(err)")
				} else {
					print("Document successfully written")
				}
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
