//
//  MapView.swift
//  SeaSwiftAndSunEarth
//
//  Created by Cynthia on 14/12/2023.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let Country: String
    let coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    let annotations = [
            Location(name: "Pipeline", Country: "Ohahu, Hawaii", coordinate: CLLocationCoordinate2D(latitude: 20.748464, longitude:  -155.992663)),
            Location(name: "Superbank", Country: "Gold Coast, Australia", coordinate: CLLocationCoordinate2D(latitude:  -28.016666, longitude: 153.399994)),
            Location(name: "Supertubes", Country: "Jeffreys Bay, South Africa", coordinate: CLLocationCoordinate2D(latitude: -34.033333, longitude: 24.916668)),
            Location(name: "Playa Chicama", Country: "Lima, Peru", coordinate: CLLocationCoordinate2D(latitude: -7.84278, longitude: -79.1439)),
            Location(name: "The Bubble", Country: "Fuerteventura, Canary Islands", coordinate: CLLocationCoordinate2D(latitude:  28.291565, longitude:  -16.629129)),
            Location(name: "Rockaway Beach", Country: "Tilammok, Oregon", coordinate: CLLocationCoordinate2D(latitude:  45.6169, longitude: -123.939)),
            Location(name: "Pasta Point", Country: "Maldives", coordinate: CLLocationCoordinate2D(latitude: 3.202834, longitude:  73.165249)),
            Location(name: "Manu Bay", Country: "Raglan, New Zealand", coordinate: CLLocationCoordinate2D(latitude: -37.822076, longitude: 174.817446)),
            Location(name: "Kitty Hawk", Country: "Outer Banks, North Carolina", coordinate: CLLocationCoordinate2D(latitude: 36.064610, longitude: -75.705735)),
            Location(name: "Skeleton Bay", Country: "Namibia", coordinate: CLLocationCoordinate2D(latitude: -20 , longitude: 13.333333)),
        ]

    var body: some View {
        Map {
            ForEach(annotations) { annotation in
                Annotation(annotation.name, coordinate: annotation.coordinate) {
                    NavigationLink {
                        DetailView()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .tint(Color("mediumBlue"))
                            VStack {
                                Image(systemName: "water.waves").foregroundStyle(.white)
                                    .font(.system(.title))
                                Text(annotation.name)
                                    .foregroundStyle(.white)
                                    .font(.footnote)
                                    .font(.body)
                                    
                                Text(annotation.Country)
                                    .foregroundStyle(.white)
                                    .font(.caption)
                                    .bold()
                            }
                            .padding()
                        }
                    }
                }
            }
        }
        .mapStyle(.hybrid(elevation: .realistic))
        .ignoresSafeArea()
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
        }
    }
}

struct DetailView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        guard let finalVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "DetailSpotViewController") as? DetailSpotViewController else {
            fatalError("Unable to instantiate DetailSpotViewController")
        }
        return finalVC
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

#Preview {
    NavigationStack {
        MapView()
    }
}
