//
//  HomepageView.swift
//  freshen-ios
//
//  Created by Klay Anthony Clarke on 6/4/22.
//

import SwiftUI
import FirebaseAuth

struct HomepageView: View {
	@EnvironmentObject var viewModel: AppViewModel
	@State var user = Auth.auth().currentUser
	var body: some View {
		VStack {
			Text("Welcome back \(user?.displayName != nil ? user?.displayName : user?.email?.split(separator: "@")[0])" as String)
			Button(action: {
				viewModel.signOut()
			}, label: {
				Text("Sign Out")
					.frame(width: 200, height: 50, alignment: .center)
					.foregroundColor(Color.blue)
			})
		}
	}
}

struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
    }
}
