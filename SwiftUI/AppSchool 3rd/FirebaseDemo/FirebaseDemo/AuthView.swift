//
//  AuthView.swift
//  FirebaseDemo
//
//  Created by Minjae Kim on 1/9/24.
//

import SwiftUI
import FirebaseAuth

struct AuthView: View {

	@ObservedObject var authManager = AuthManager.shared

	var body: some View {
		NavigationStack {
			VStack {
				if authManager.state == .signedOut {

					AuthSignInView()

				} else {
					HStack {
						Button("Sign out") {
							authManager.signOut()
						}
						Button("탈퇴") {
							authManager.deleteUser()
						}
					}

					StorageView()
				}
			}
			.padding()
			.onAppear {
				authManager.checkSignIn()
			}
		}
	}
}

#Preview {
    AuthView()
}
