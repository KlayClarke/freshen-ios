//
//  ExploreView.swift
//  Freshen
//
//  Created by Klay Anthony Clarke on 6/13/23.
//

import SwiftUI

struct URLImage: View {
    let urlString: String
    
    @State var data: Data?
    
    var body: some View {
        if let data = data, let uiimage = UIImage(data: data) {
            // create border to wrap around fetched image
            Image(uiImage: uiimage)
                .resizable()
        } else {
            Image("")
                .resizable()
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
    @StateObject var apiCaller = APICaller()
    
    @State var sortBy: Sorter = Sorter.alphabetically
    @State var isShowingSortBySheet: Bool = false
    
    var body: some View {
        NavigationStack {
            Picker("Sort by", selection: $sortBy) {
                Text("Sort By Name").tag(Sorter.alphabetically)
                Text("Sort By Type").tag(Sorter.type)
                Text("Sort By Price").tag(Sorter.price)
            }
            .pickerStyle(.segmented)
            List(apiCaller.salons, id: \.self) { salon in
                NavigationLink(destination: DetailView(salon: salon)) {
                    HStack {
                        URLImage(urlString: salon.image)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 130, height: 70)
                            .background(Color.gray)
                        VStack {
                            Text("\(salon.name) - $\(salon.average_price)")
                                .bold()
                        }
                    }
                    .padding(3)
                }
            }
            .navigationTitle("Explore")
            .onAppear {
                apiCaller.fetchSalons()
            }
            .onChange(of: sortBy) {
                apiCaller.changeSortBy(sortBy: sortBy)
            }
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
