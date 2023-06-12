//
//  MapboxView.swift
//  Freshen
//
//  Created by Klay Anthony Clarke on 6/11/23.
//

import SwiftUI
import UIKit
import MapboxMaps

let MBX_PUBLIC_TOKEN: String? = ProcessInfo.processInfo.environment["MBX_PUBLIC_TOKEN"]

class ViewController: UIViewController {
    internal var mapView: MapView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let myResourceOptions = ResourceOptions(accessToken: MBX_PUBLIC_TOKEN ?? "")
        let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions)
        mapView = MapView(frame: view.bounds, mapInitOptions: myMapInitOptions)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(mapView)
    }
}

struct MyView: UIViewControllerRepresentable {
    typealias UIViewControllerType = ViewController
    
    func makeUIViewController(context: Context) -> ViewController {
        let vc = ViewController()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        
    }
}

struct MapboxView: View {
    @State var isPresented = false
    var body: some View {
        Button("Open Map") {
            isPresented = true
        }
        .sheet(isPresented: $isPresented) {
            MyView()
                .ignoresSafeArea()
        }
    }
}
