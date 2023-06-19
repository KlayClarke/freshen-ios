//
//  APICaller.swift
//  Freshen
//
//  Created by Klay Anthony Clarke on 6/18/23.
//

import Foundation
import SwiftUI
import MapKit

class APICaller: ObservableObject {
    @Published var salons: [SalonElement] = []
    
    func fetchSalons() {
        guard let url = URL(string: "https://freshenv3.vercel.app/api/salons/get".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            // Convert to JSON
            do {
                let apiReturnElement = try JSONDecoder().decode(ApiReturnElement.self, from: data) as ApiReturnElement
                var salons = apiReturnElement.features as [SalonElement]
                
                
                // Sort by name
                salons.sort(by: { $0.name < $1.name })
                
                DispatchQueue.main.async {
                    self?.salons = salons
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
        
    }
    
    func changeSortBy(sortBy: Sorter) {
        // Sort api response based on input sortedBy
        if sortBy == Sorter.alphabetically {
            // sort by alpha
            self.salons.sort(by: { $0.name < $1.name })
        } else if sortBy == Sorter.type {
            // sort by type
            self.salons.sort(by: { $0.salon_type < $1.salon_type })
        } else {
            // sort by price
            self.salons.sort(by: { $0.average_price < $1.average_price })
        }
    }
}
