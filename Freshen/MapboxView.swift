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

public class MapboxViewController: UIViewController {
    internal var mapView: MapView!
    
    // add back button
    @IBAction func goBackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // add backbutton
        let backbutton = UIButton(type: .custom)
        backbutton.setTitle("Back", for: .normal)
        backbutton.setTitleColor(backbutton.tintColor, for: .normal)
        backbutton.addTarget(self, action: "backAction", for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
        
        // initialize map view centered over US
        let center = CLLocationCoordinate2D(latitude: 40.669957, longitude: -103.5917968)
        let cameraOptions = CameraOptions(center: center, zoom: 2)
        let myResourceOptions = ResourceOptions(accessToken: MBX_PUBLIC_TOKEN ?? "")
        let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions, cameraOptions: cameraOptions)
        mapView = MapView(frame: view.bounds, mapInitOptions: myMapInitOptions)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(mapView)
        
        mapView.mapboxMap.onNext(event: .styleLoaded) { _ in
            self.addPointClusters()
        }
    }
    
    func backAction() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    func addPointClusters() {
        let style = self.mapView.mapboxMap.style
        // Parse GeoJSON data.
        guard let url = URL(string: "http://freshenv3.vercel.app/api/salons/get") else { return }
        
        // Create a GeoJSONSource from data URL
        var source = GeoJSONSource()
        source.data = .url(url)
        
        // Set the cluster properties directly on the source
        source.cluster = true
        source.clusterRadius = 50
        
        // The maximum zoom level where points will be clustered
        source.clusterMaxZoom = 14
        let sourceID = "freshen-salons"
        
        // Create three spearate layers from the same source.
        // 'clusterLayer' contains clustered point features
        var clusteredLayer = createClusteredLayer()
        clusteredLayer.source = sourceID
        
        // 'unclusteredLayer' contains individual point featuers that do not represent clusters
        var unclusteredLayer = createUnclusteredLayer()
        unclusteredLayer.source = sourceID
        
        // 'clusterCountLayer' is a 'SymbolLayer' that represents the point count within individual clusters
        var clusterCountLayer = createNumberLayer()
        clusterCountLayer.source = sourceID
        
        // Add source and layers to the map view's style
        try! style.addSource(source, id: sourceID)
        try! style.addLayer(clusteredLayer)
        try! style.addLayer(unclusteredLayer, layerPosition: .below(clusteredLayer.id))
        try! style.addLayer(clusterCountLayer)
    }
    
    func createClusteredLayer() -> CircleLayer {
        // Create a 'CircleLayer' that only contains clustered points
        var clusteredLayer = CircleLayer(id: "clustered-freshen-salons-layer")
        clusteredLayer.filter = Exp(.has) { "point_count" }
        
        // Set the circle's color and radius based on the number of points within each cluster
        clusteredLayer.circleColor = .expression(Exp(.step) {
            Exp(.get) {"point_count"}
            UIColor(red: 0.32, green: 0.73, blue: 0.84, alpha: 1.00)
            100
            UIColor(red: 0.95, green: 0.94, blue: 0.46, alpha: 1.00)
            750
            UIColor(red: 0.95, green: 0.55, blue: 0.69, alpha: 1.00)
        })
        
        clusteredLayer.circleRadius = .expression(Exp(.step) {
            Exp(.get) { "point_count" }
            20
            100
            30
            750
            40
        })
        
        return clusteredLayer
    }
    
    func createUnclusteredLayer() -> CircleLayer {
        var unclusteredLayer = CircleLayer(id: "unclusteredPointLayer")
        
        // Filter out clusters by checking for point_count.
        unclusteredLayer.filter = Exp(.not) {
            Exp(.has) { "point_count" }
        }
        
        unclusteredLayer.circleColor = .constant(StyleColor(UIColor(red: 0.07, green: 0.71, blue: 0.85, alpha: 1.00)))
        unclusteredLayer.circleRadius = .constant(8)
        unclusteredLayer.circleStrokeWidth = .constant(1)
        unclusteredLayer.circleStrokeColor = .constant(StyleColor(.black))
        return unclusteredLayer
    }
    
    func createNumberLayer() -> SymbolLayer {
        var numberLayer = SymbolLayer(id: "cluster-count-layer")
        
        // Check whether the point feature is clustered.
        numberLayer.filter = Exp(.has) { "point_count" }
        
        // Display the value for 'point_count' in the text field
        numberLayer.textField = .expression(Exp(.get) { "point_count" })
        numberLayer.textSize = .constant(12)
        return numberLayer
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

struct MyView: UIViewControllerRepresentable {
    typealias UIViewControllerType = MapboxViewController
    
    func makeUIViewController(context: Context) -> MapboxViewController {
        let vc = MapboxViewController()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: MapboxViewController, context: Context) {
        
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

struct MapboxView_Previews: PreviewProvider {
    static var previews: some View {
        MapboxView()
    }
}


// TODO:
// - repurpose click for opening banner above salon / restaurant
