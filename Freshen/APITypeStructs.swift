//
//  APITypeStructs.swift
//  Freshen
//
//  Created by Klay Anthony Clarke on 6/11/23.
//

import Foundation

typealias Salons = [SalonElement]

struct FeatureElement: Codable {
    let features: Salons
}

struct SalonElement: Codable, Hashable {
    static func == (lhs: SalonElement, rhs: SalonElement) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    let geometry: GeometryElement
    let id: String
    let name: String
    let type: String
    let average_price: Int
    let image: String
    let street_address: String
    let city: String
    let state: String
    let zip_code: String
    let properties: PropertyElement
}

struct GeometryElement: Codable {
    let type: String
    let coordinates: [Double]
}

struct PropertyElement: Codable {
    let mapboxClusterHTML: String
}

enum Type: String, Codable {
    case barbershop = "Barbershop"
    case hybrid = "Hybrid"
    case salon = "Salon"
}
