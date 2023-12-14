//
//  SegmentedControlView.swift
//  SeaSwiftAndSunEarth
//
//  Created by Cynthia on 14/12/2023.
//

import SwiftUI
import CoreLocation
import UIKit

struct SegmentedControlView: View {
    @State private var choice = "List"
    var categories = ["List", "Map"]
    @State private var isDetailViewPresented = false
    @EnvironmentObject var authService: AuthService

    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Choose your category",
                       selection: $choice) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(.segmented)
                if (choice == "List") {
                    NavigationView()
                } else {
                  
                }
                Spacer()
            }
            .navigationTitle("Surf Spots")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Action to perform when the button is tapped
                        isDetailViewPresented.toggle()
                    }) {
                        // Display an SF Symbol
                        Image(systemName: "person.crop.circle")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                }
            }
            .sheet(isPresented: $isDetailViewPresented) {
                // SwiftUI view to present when the button is tapped
                AuthenticationView()
                    .environmentObject(AuthService())
            }
        }
    }
}
struct NavigationView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        guard let finalVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "ViewController") as? ViewController else {
            fatalError("Unable to instantiate NavigationController")
        }
        return finalVC
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
}

#Preview {
    SegmentedControlView()
        .environmentObject(AuthService())
}
