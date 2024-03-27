//
//  ThirdFormsPageView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/9/23.
//

import SwiftUI

struct ThirdFormsPageView: View {
	@Binding var stackPath: NavigationPath
	@State private var selected: Int = -1
	@State private var text: String = ""
	
	let index = 4
	var body: some View {
		Form {
			Section {
				AppSchoolImageView()
			}
			
			Section {
				
			} header: {
				Text("운영 만족도")
					.font(.title3)
					.foregroundStyle(.black)
			}
			
			Section {
				VStack {
					Text(questions[8].question)
					Picker(selection: $selected, label: Text("")) {
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
					Text(questions[9].question)
					TextField("내 답변", text: $text)
						.textFieldStyle(.roundedBorder)
				}
			}
			
			Section {
				HStack {
					NavigationLink(destination: FourthFormsPageView(stackPath: $stackPath)) {
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
//    ThirdFormsPageView()
//}
