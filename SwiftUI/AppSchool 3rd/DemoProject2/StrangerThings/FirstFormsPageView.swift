//
//  FirstFormsPageView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/9/23.
//

import SwiftUI

struct FirstFormsPageView: View {
	@Binding var stackPath: NavigationPath
	@State private var selected: [Int] = Array(repeating: -1, count: 6)
	let index = 2
	
	var body: some View {
		Form {
			Section {
				AppSchoolImageView()
			}
			
			Section {
				
			} header: {
				Text("교육 만족도")
					.font(.title3)
					.foregroundStyle(.black)
			}
			
			Section {
				VStack {
					Text(questions[0].question)
					Picker(selection: $selected[0], label: Text("")) {
						Text("매우어려움").tag(1)
						Text("어려움").tag(2)
						Text("보통").tag(3)
						Text("쉬움").tag(4)
						Text("매우쉬움").tag(5)
					}
					.pickerStyle(.inline)
					.onChange(of: selected[0]) { _ in
						print(selected)
					}
				}
			}
			
			Section {
				VStack {
					Text(questions[1].question)
					Picker(selection: $selected[1], label: Text("")) {
						Text("매우빠르다").tag(1)
						Text("빠르다").tag(2)
						Text("보통").tag(3)
						Text("느려").tag(4)
						Text("매우느려").tag(5)
					}
					.pickerStyle(.inline)
				}
			}
			
			Section {
				VStack {
					Text(questions[2].question)
					Picker(selection: $selected[2], label: Text("")) {
						Text("매우부족").tag(1)
						Text("부족").tag(2)
						Text("보통").tag(3)
						Text("많다").tag(4)
						Text("매우많다").tag(5)
					}
					.pickerStyle(.inline)
				}
			}
			
			Section {
				VStack {
					Text(questions[3].question)
					Picker(selection: $selected[3], label: Text("")) {
						Text("매우만족").tag(1)
						Text("만족").tag(2)
						Text("보통").tag(3)
						Text("불만족").tag(4)
						Text("매우불만족").tag(5)
					}
					.pickerStyle(.inline)
				}
			}
			
			Section {
				VStack {
					Text(questions[4].question)
					Picker(selection: $selected[4], label: Text("")) {
						Text("매우만족").tag(1)
						Text("만족").tag(2)
						Text("보통").tag(3)
						Text("불만족").tag(4)
						Text("매우불만족").tag(5)
					}
					.pickerStyle(.inline)
				}
			}
			
			Section {
				VStack {
					Text(questions[5].question)
					Picker(selection: $selected[5], label: Text("")) {
						Text("매우도움됨").tag(1)
						Text("도움됨").tag(2)
						Text("보통").tag(3)
						Text("안됨").tag(4)
						Text("매우안됨").tag(5)
					}
					.pickerStyle(.inline)
				}
			}
			
			Section {
				HStack {
					//					Button {
					//						stackPath.removeLast()
					//					} label: {
					//						Text("뒤로")
					//					}
					//					.buttonStyle(.bordered)
					//
					//					Spacer()
					
					NavigationLink(destination: SecondFormsPageView(stackPath: $stackPath)) {
						Text("다음")
					}
					
					Spacer()
					
					FormProgressView(value: index)
					
					Spacer()
					
					Button {
						
					} label: {
						Text("양식 지우기")
					}
					.buttonStyle(.borderless)
				}
			}
		}
	}
}

//#Preview {
//    FirstFormsPageView()
//}
