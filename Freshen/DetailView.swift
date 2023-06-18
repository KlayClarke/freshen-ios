//
//  DetailView.swift
//  Freshen
//
//  Created by Klay Anthony Clarke on 6/13/23.
//

import SwiftUI

struct DetailView: View {
    let salon: SalonElement?
    
    var body: some View {
        URLImage(urlString: salon!.image)
        Text(salon!.name)
        Text(salon!.salon_type)
    }
}
