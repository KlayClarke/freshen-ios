//
//  freshen_iosApp.swift
//  freshen-ios
//
//  Created by Klay Anthony Clarke on 6/3/22.
//

import SwiftUI
import FirebaseCore

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
