//
//  IOSMapView.swift
//  Freshen
//
//  Created by Klay Anthony Clarke on 6/18/23.
//

import Foundation
import SwiftUI
import UIKit
import MapKit

class IOSMapViewController: ObservableObject {
    var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 39, longitude: -98), span: MKCoordinateSpan(latitudeDelta: 60, longitudeDelta: 60))
}

struct IOSMapView: View {
    @ObservedObject var iosMapViewController: IOSMapViewController
    
    @StateObject var apiCaller: APICaller = APICaller()
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $iosMapViewController.region, annotationItems: apiCaller.salons, annotationContent: { salon in
                MapMarker(coordinate: CLLocationCoordinate2D(latitude: salon.geometry.coordinates[1], longitude: salon.geometry.coordinates[0]), tint: .blue)
            })
                .ignoresSafeArea(.container, edges: [.top])
        }
        .onAppear {
            apiCaller.fetchSalons()
        }
    }
}

struct IOSMapView_Previews: PreviewProvider {
    static var previews: some View {
        IOSMapView(iosMapViewController: IOSMapViewController())
    }
}
