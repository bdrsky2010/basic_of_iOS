//
//  FifthFormsPageView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/9/23.
//

import SwiftUI

struct FifthFormsPageView: View {
	@Binding var stackPath: NavigationPath
	@State private var text: [String] = Array(repeating: "", count: 4)
	var body: some View {
		Form {
			Section {
				AppSchoolImageView()
			}
			
			Section {
				VStack(alignment: .leading) {
					Text("7&8주차 설문")
						.font(.title)
					Spacer()
					Text("""
이번주도 고생 많으셨습니다!
주말동안 가득 충전하고, 다음주에 다시 힘차게 뵙겠습니다 🤗
""")
				}
			}
		}
		.navigationBarBackButtonHidden(true)
	}
}

//#Preview {
//    FifthFormsPageView()
//}
