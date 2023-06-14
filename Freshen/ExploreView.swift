//
//  ExploreView.swift
//  Freshen
//
//  Created by Klay Anthony Clarke on 6/13/23.
//

import SwiftUI

class ExploreViewModel: ObservableObject {
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
                let salons = apiReturnElement.features as [SalonElement]
                DispatchQueue.main.async {
                    self?.salons = salons
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
        
    }
}

struct URLImage: View {
    let urlString: String
    
    @State var data: Data?
    
    var body: some View {
        if let data = data, let uiimage = UIImage(data: data) {
            // create border to wrap around fetched image
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 130, height: 70)
                .background(Color.gray)
        } else {
            Image("")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 130, height: 70)
                .background(Color.gray)
                .onAppear {
                    fetchData()
                }
        }
    }
    
    private func fetchData() {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.data = data
        }
        
        task.resume()
    }
}

struct ExploreView: View {
    @StateObject var exploreViewModel = ExploreViewModel()
    var body: some View {
        NavigationStack {
            List(exploreViewModel.salons, id: \.self) { salon in
                NavigationLink(destination: EmptyView()) {
                    HStack {
                        ZStack {
                            URLImage(urlString: salon.image)
                        }
                        .frame(width: 130, height: 70)
                        Text(salon.name)
                            .bold()
                    }
                    .padding(3)
                }
            }
            .navigationTitle("Explore")
            .onAppear {
                exploreViewModel.fetchSalons()
            }
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
