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
    
    @State private var isSignedUp = false
    @State private var accountActionMessage: String? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("lightBlue")
                    .ignoresSafeArea()
                    .opacity(0.5)
                
                VStack {
                    Spacer()
                    
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
                    
                    Button(action: {
                        if isSignedUp {
                            authService.regularSignIn(email: email, password: password) { error in
                                if let e = error {
                                    print(e.localizedDescription)
                                    accountActionMessage = "Failed to Log In"
                                } else {
                                    accountActionMessage = "Logged In Successfully"
                                }
                            }
                        } else {
                            authService.regularCreateAccount(email: email, password: password)
                            isSignedUp = true
                            accountActionMessage = "Account Created"
                            email = ""
                            password = ""
                        }
                    }) {
                        Text(isSignedUp ? "Log In" : "Create an Account")
                            .foregroundColor(Color("lightBlue"))
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .tint(Color("darkBlue"))
                    
                    if let message = accountActionMessage {
                        Text(message)
                            .foregroundColor(message.contains("Successfully") ? .green : .red)
                            .padding(.top, 8)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text(isSignedUp ? "Don't have an account yet?" : "Already have an account?")
                        
                        Button(action: {
                            isSignedUp.toggle()
                        }) {
                            Text(isSignedUp ? "Create an Account" : "Log In")
                                .foregroundColor(Color("mediumBlue"))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
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
