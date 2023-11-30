//
//  NewsList.swift
//  SwiftAPIDemo
//
//  Created by Minjae Kim on 11/30/23.
//

import SwiftUI

struct NewsList: View {
	@StateObject var network = NewsAPI.shared
	
	var body: some View {
		List {
			ForEach(network.posts, id: \.self) { result in
				HStack {
					AsyncImage(url: URL(string: result.urlToImage ?? "")) { image in
						image.image?.resizable()
					}
					.frame(width: 120, height: 80)
					
					Text(result.title)
						.bold()
				}
			}
		}
		.onAppear {
			network.feachData()
		}
	}
}

#Preview {
    NewsList()
}
