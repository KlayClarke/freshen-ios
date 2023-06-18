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
    
    var body: some View {
        Map(coordinateRegion: $iosMapViewController.region)
            .ignoresSafeArea(.container, edges: [.top])
    }
}

struct IOSMapView_Previews: PreviewProvider {
    static var previews: some View {
        IOSMapView(iosMapViewController: IOSMapViewController())
    }
}
