//
//  AppSchoolImageView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/9/23.
//

import SwiftUI

struct AppSchoolImageView: View {
    var body: some View {
		Image(uiImage: .appschool)
			.resizable()
			.frame(height: 150)
			.aspectRatio(contentMode: .fit)
    }
}

#Preview {
    AppSchoolImageView()
}
