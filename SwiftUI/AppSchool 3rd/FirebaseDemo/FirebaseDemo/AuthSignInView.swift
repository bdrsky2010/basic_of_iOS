//
//  AuthSignInView.swift
//  FirebaseDemo
//
//  Created by Minjae Kim on 1/9/24.
//

import SwiftUI

struct AuthSignInView: View {

	@ObservedObject var authManager = AuthManager.shared

	@State private var emailText = ""
	@State private var passwordText = ""
	@State private var isProcessing = false

	var body: some View {
		NavigationStack {
			VStack {
				TextField("Email", text: $emailText)
				SecureField("Password", text: $passwordText)

				if isProcessing {
					ProgressView()
				}

				Button("Sign in") {
					isProcessing = true
					authManager.emailAuthSignIn(email: emailText, password: passwordText)
				}
				.disabled(emailText.isEmpty || passwordText.isEmpty)


				NavigationLink {
					AuthSignUpView()
				} label: {
					Text("가입")
				}
			}
			.padding()
		}
	}
}

#Preview {
    AuthSignInView()
}
