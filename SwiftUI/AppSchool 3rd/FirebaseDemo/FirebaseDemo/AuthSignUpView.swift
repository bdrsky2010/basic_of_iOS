//
//  AuthSignUpView.swift
//  FirebaseDemo
//
//  Created by Minjae Kim on 1/9/24.
//

import SwiftUI

struct AuthSignUpView: View {
	
	@Environment(\.dismiss) private var dismiss
	
	@ObservedObject var authManager = AuthManager.shared
	
	@State private var nameText: String = ""
	@State private var isNameCountError: Bool = false
	
	@State private var emailText: String = ""
	@State private var isEmailError: Bool = false
	
	@State private var passwordText: String = ""
	@State private var isPasswordCountError: Bool = false
	
	@State private var passwordConfirmText: String = ""
	@State private var isPasswordConfirmError: Bool = false
	
	
    var body: some View {
		VStack {
			VStack(alignment: .leading) {
				Text("이름")
					.font(.headline)
				TextField("이름을 입력하세요.", text: $nameText)
					.textFieldStyle(.roundedBorder)
					.textInputAutocapitalization(.never)
					.onChange(of: nameText) {
						isNameCountError = nameText.count < 2 ? true : false
					}
				Text("이름은 2자 이상 입력해주세요.")
					.font(.system(size: 16))
					.foregroundStyle(isNameCountError ? .red : .clear)
					.frame(maxWidth: .infinity, alignment: .trailing)
			}
			
			VStack(alignment: .leading) {
				Text("이메일")
					.font(.headline)
				TextField("이메일 입력하세요.", text: $emailText)
					.textFieldStyle(.roundedBorder)
					.textInputAutocapitalization(.never)
					.onChange(of: emailText) {
						isEmailError = !isValidEmail(emailText) ? true : false
					}
				Text("이메일 입력하세요.")
					.font(.system(size: 16))
					.foregroundStyle(isEmailError ? .red : .clear)
					.frame(maxWidth: .infinity, alignment: .trailing)
			}
			
			VStack(alignment: .leading) {
				Text("비밀번호")
					.font(.headline)
				SecureField("비밀번호를 6자 이상 입력하세요.", text: $passwordText)
					.textFieldStyle(.roundedBorder)
					.textInputAutocapitalization(.never)
					.onChange(of: passwordText) {
						isPasswordCountError = passwordText.count < 6 ? true : false
					}
				Text("비밀번호를 6자리 이상 입력하세요.")
					.font(.system(size: 16))
					.foregroundStyle(isPasswordCountError ? .red : .clear)
				
				SecureField("비밀번호를 다시 입력하세요.", text: $passwordConfirmText)
					.textFieldStyle(.roundedBorder)
					.textInputAutocapitalization(.never)
					.onChange(of: passwordConfirmText) {
						isPasswordConfirmError = passwordConfirmText != passwordText ? true : false
					}
				Text("비밀번호가 서로 다릅니다.")
					.font(.system(size: 16))
					.foregroundStyle(isPasswordConfirmError ? .red : .clear)
			}
			Button("가입") {
				authManager.emailAuthSignUp(userName: nameText, email: emailText, password: passwordText)
				dismiss()
			}
			.disabled(!checkSingUpCond())
		}
		.padding()
    }
	
	// 가입 버튼 체크 함수
	func checkSingUpCond() -> Bool {
		if isNameCountError || isEmailError || isPasswordCountError || isPasswordConfirmError {
			return false
		}
		return true
	}
	
	// 이메일 형식 검사
	func isValidEmail(_ email: String) -> Bool {
		let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
		let emailConfirm = NSPredicate(format: "self matches %@", emailRegex)
		return emailConfirm.evaluate(with: email)
	}
}

//#Preview {
//    AuthSignUpView()
//}
