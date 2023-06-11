//
//  APICaller.swift
//  Freshen
//
//  Created by Klay Anthony Clarke on 6/11/23.
//

import Foundation

final class APICaller {
    static let instance = APICaller()
    private init() {}
    
    func fetchSalons() async throws -> FeatureElement {
        let url = URL(string: "https://freshenv3.vercel.app/api/salons/get".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        let request = URLRequest(url: url!)
        let (data, response) = try await URLSession.shared.data(for: request)
        let fetchedData = try JSONDecoder().decode(FeatureElement.self, from: try mapResponse(response: (data, response)))
        print(fetchedData)
        return fetchedData
    }
    
    func retrieveSalons() {
        Task {
            do {
                _ = try await APICaller.instance.fetchSalons()
            } catch {
                print(error)
            }
        }
    }
}
