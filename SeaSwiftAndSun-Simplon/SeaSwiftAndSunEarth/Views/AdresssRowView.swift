//
//  AdresssRowView.swift
//  SeaSwiftAndSunEarth
//
//  Created by Cynthia on 14/12/2023.
//

import SwiftUI

struct AddressRow: View {
    
    let address: AddressResult
    
    var body: some View {
        NavigationLink {
            MapView(viewModel: ContentViewModel, address: address)
        } label: {
            VStack(alignment: .leading) {
                Text(address.title)
                Text(address.subtitle)
                    .font(.caption)
            }
        }
        .padding(.bottom, 2)
    }
}

#Preview {
    AddresssRow()
}
