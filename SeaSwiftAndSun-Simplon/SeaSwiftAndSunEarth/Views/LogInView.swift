//
//  LogInView.swift
//  SeaSwiftAndSunEarth
//
//  Created by Keyhan Mortezaeifar on 14/12/2023.
//

import SwiftUI

struct LogInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var authService: AuthService
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray
                    .ignoresSafeArea()
                    .opacity(0.5)
                
                VStack {
                    TextField("Email", text: $email)
                        .textFieldStyle(.roundedBorder)
                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Login") {
                        authService.regularSignIn(email: email, password: password) { error in
                            if let e = error {
                                print(e.localizedDescription)
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    
                    HStack {
                        Text("Don't have an account?")
                        
                        NavigationLink(destination: AuthenticationView()) {
                            Text("Create Account").foregroundColor(.blue)
                        }
                    }.frame(maxWidth: .infinity, alignment: .center)
                }
                .padding()
            }
        }
    }
}

#Preview {
    LogInView()
        .environmentObject(AuthService())
    
}
