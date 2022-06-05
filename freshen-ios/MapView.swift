//
//  MapView.swift
//  freshen-ios
//
//  Created by Klay Anthony Clarke on 6/5/22.
//

import Foundation
import UIKit
import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
	
	typealias UIViewType = UIView
	
	func makeUIView(context: Context) -> UIView {
		let view = UIView()
		
		let coordinates = CLLocationCoordinate2D(latitude: 43, longitude: -75)
		let map = MKMapView()
		map.setRegion(MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)), animated: true)
		view.addSubview(map)
		map.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			map.widthAnchor.constraint(equalTo: view.widthAnchor),
			map.heightAnchor.constraint(equalTo: view.heightAnchor),
			map.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			map.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		])
		return view
	}
	
	func updateUIView(_ uiView: UIView, context: Context) {
		// do nothing
	}
	
	
}
