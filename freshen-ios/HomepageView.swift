//
//  HomepageView.swift
//  freshen-ios
//
//  Created by Klay Anthony Clarke on 6/4/22.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore
import MapKit
import CoreLocation

struct HomepageView: View {
	@EnvironmentObject var viewModel: AppViewModel
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
			GeometryReader {proxy in
				MapView()
					.frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
			}
		}
	}
}

struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
    }
}
