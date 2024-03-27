//
//  FourthFormsPageView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/9/23.
//

import SwiftUI

struct FourthFormsPageView: View {
	@Binding var stackPath: NavigationPath
	@State private var text: [String] = Array(repeating: "", count: 4)
	
	let index = 5
	var body: some View {
		Form {
			Section {
				AppSchoolImageView()
			}
			
			Section {
				
			} header: {
				Text("기타 건의사항")
					.font(.title3)
					.foregroundStyle(.black)
			}
			
			Section {
				VStack {
					Text(questions[10].question)
					TextField("내 답변", text: $text[0])
						.textFieldStyle(.roundedBorder)
				}
			}
			
			Section {
				VStack {
					Text(questions[11].question)
					TextField("내 답변", text: $text[1])
						.textFieldStyle(.roundedBorder)
				}
			}
			
			Section {
				VStack {
					Text(questions[12].question)
					TextField("내 답변", text: $text[2])
						.textFieldStyle(.roundedBorder)
				}
			}
			
			Section {
				VStack {
					Text(questions[13].question)
					TextField("내 답변", text: $text[3])
						.textFieldStyle(.roundedBorder)
				}
			}
			
			Section {
				HStack {
					NavigationLink(destination: FifthFormsPageView(stackPath: $stackPath)) {
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
//    FourthFormsPageView()
//}
