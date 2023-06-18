//
//  NavigationView.swift
//  Freshen
//
//  Created by Klay Anthony Clarke on 6/17/23.
//

import Foundation
import SwiftUI

struct NavigationView: View {
    var body: some View {
        TabView {
            IOSMapView(iosMapViewController: IOSMapViewController(), apiCaller: APICaller())
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
            ExploreView()
                .tabItem {
                    Image(systemName: "chart.bar.doc.horizontal")
                    Text("Explore")
                }
        }
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView()
    }
}
