//
//  ContextMenuDemoView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/9/23.
//
/**
 # ContextMenu
 
 사용자가 뷰를 롱 프레스 했을 때 나타나는 메뉴
 
 일반적으로 Text, Image와 함께 선택했을 때 동작을 수행하도록 Button 뷰를 포함
 */
import SwiftUI

struct ContextMenuDemoView: View {
	@State private var foregroundColor: Color = .black
	@State private var backgroundColor: Color = .white
	
	var body: some View {
		Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
			.padding()
			.font(.largeTitle)
			.foregroundStyle(foregroundColor)
			.background(backgroundColor)
			.contextMenu {
				Button {
					
				} label: {
					Text("Normal Colors")
					Image(systemName: "paintbrush")
				}
				
				Button {
					self.foregroundColor = foregroundColor == .black ? .white : .black
					self.backgroundColor = backgroundColor == .black ? .white : .black
				} label: {
					Text("Inverted Colors")
					Image(systemName: "paintbrush.fill")
				}


			}
	}
}

#Preview {
	ContextMenuDemoView()
}
