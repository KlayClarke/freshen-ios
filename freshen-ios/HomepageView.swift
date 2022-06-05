//
//  HomepageView.swift
//  freshen-ios
//
//  Created by Klay Anthony Clarke on 6/4/22.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct HomepageView: View {
	@EnvironmentObject var viewModel: AppViewModel
	func getData() {
		viewModel.db.collection("users").getDocuments { querySnapshot, err in
			if let err = err {
				print("Error getting documents: \(err)")
			} else {
				for document in querySnapshot!.documents {
					print("\(document.documentID) => \(document.data())")
				}
			}
		}
	}
	var body: some View {
		VStack {
			Text("Welcome back")
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
