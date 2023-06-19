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

struct IOSMapView: View {
    @StateObject var apiCaller: APICaller = APICaller()
    
    @State private var cameraPosition: MapCameraPosition = .region(.defaultRegion)
    
    var body: some View {
        Map(position: $cameraPosition) {
            ForEach(apiCaller.salons) { salon in
                Marker("\(salon.name)", coordinate: CLLocationCoordinate2D(latitude: salon.geometry.coordinates[1], longitude: salon.geometry.coordinates[0]))
            }
        }
        .onAppear {
            apiCaller.fetchSalons()
        }
    }
}

struct IOSMapView_Previews: PreviewProvider {
    static var previews: some View {
        IOSMapView()
    }
}


// Location Data
extension CLLocationCoordinate2D {
    static var defaultLocation: CLLocationCoordinate2D {
        return .init(latitude: 39, longitude: -98)
    }
}

extension MKCoordinateRegion {
    static var defaultRegion: MKCoordinateRegion {
        return .init(center: .defaultLocation, latitudinalMeters: 10000000, longitudinalMeters: 10000000)
    }
}
