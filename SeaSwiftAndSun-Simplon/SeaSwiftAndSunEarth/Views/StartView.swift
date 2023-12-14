//
//  StartView.swift
//  SeaSwiftAndSunEarth
//
//  Created by Keyhan Mortezaeifar on 14/12/2023.
//

import SwiftUI
import FirebaseAuth

struct StartView: View {
    @EnvironmentObject var authService: AuthService
    
    var body: some View {
        if authService.signedIn {
            HomeView()
        } else {
            AuthenticationView()
        }
    }
}

struct StartView_Previews: PreviewProvider {
    @StateObject static var authService = AuthService()

    static var previews: some View {
        if authService.signedIn {
            HomeView()
        } else {
            AuthenticationView()
        }
    }
}
