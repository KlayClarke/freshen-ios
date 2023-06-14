//
//  APITypeStructs.swift
//  Freshen
//
//  Created by Klay Anthony Clarke on 6/11/23.
//

import Foundation

struct ApiReturnElement: Codable {
    let type: String
    let crs: CRSElement
    let features: [SalonElement]
}

struct CRSElement: Codable {
    let type: String
    let properties: CRSPropertiesElement
    
}

struct CRSPropertiesElement: Codable {
    let name: String
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
    let salon_type: String
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

// For sorting salons
enum Sorter: String, Codable {
    case alphabetically = "Alphabetically"
    case type = "Type"
    case price = "Price"
}
