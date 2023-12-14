//
//  AuthenticationView.swift
//  SeaSwiftAndSunEarth
//
//  Created by Keyhan Mortezaeifar on 14/12/2023.
//

import SwiftUI

struct AuthenticationView: View {
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
                    Button {
                        print("Tapped Apple Sign In")
                        authService.startSignInWithAppleFlow()
                    } label: {
                        Image("continueWithApple")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300)
                    }
                    
                    Text("OR")
                    TextField("Email", text: $email)
                        .textFieldStyle(.roundedBorder)
                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Create an Account") {
                        authService.regularCreateAccount(email: email, password: password)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    
                    HStack {
                        Text("Already have an account?")
                        
                        NavigationLink(destination: LogInView()) {
                            Text("Log In").foregroundColor(.blue)
                        }
                    }.frame(maxWidth: .infinity, alignment: .center)
                }
                .padding()
            }
        }
    }
}

#Preview {
    AuthenticationView()
        .environmentObject(AuthService())
}
