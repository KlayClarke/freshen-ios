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
    var body: some View {
        ZStack {
            Map()
                .ignoresSafeArea()
            VStack(spacing: 0) {
                headerView(salons: apiCaller.salons)
                Spacer()
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

extension IOSMapView {
    private func headerView(salons: [SalonElement]) -> some View {
        VStack {
            Text("Random Location Name")
                .font(.title2)
                .fontWeight(.black)
                .foregroundStyle(.primary)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    Image(systemName: "arrow.down")
                        .font(.headline)
                        .foregroundStyle(.primary)
                        .padding()
                }
            salonsListView(salons: salons)
        }
        .background(.thickMaterial)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
        .padding()
    }
    
    private func salonsListView(salons: [SalonElement]) -> some View {
        List {
            ForEach(salons) { salon in
                HStack {
                    URLImage(urlString: salon.image)
                        .scaledToFill()
                        .frame(width: 45, height: 45)
                        .clipShape(.rect(cornerRadius: 10))
                    VStack(alignment: .leading) {
                        Text(salon.name)
                            .font(.headline)
                        Text("\(salon.city), \(salon.state)")
                            .font(.subheadline)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}
