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
	let auth = Auth.auth()
	var body: some View {
		NavigationView {
			if viewModel.signedIn {
				HomepageView()
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

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
			.environmentObject(AppViewModel())
	}
}


