//
//  DrawView.swift
//  ARDemo
//
//  Created by Minjae Kim on 1/10/24.
//

import SwiftUI
import PencilKit

struct DrawView: View {
	@EnvironmentObject var viewModel: ViewModel
	@State var selectedColor = Color.black
    var body: some View {
		NavigationStack {
			ZStack {
				DrawingView(canvasView: $viewModel.canvasView, selectedColor: $selectedColor)
				
				VStack {
					HStack(spacing: 10) {
						ColorPicker("Color", selection: $selectedColor)
							.labelsHidden()
						
						// 그리기를 지우는 버튼
						Button("Clear") {
							viewModel.canvasView.drawing = PKDrawing()
						}
						
						// 그림을 이미지로 변환하고 보기를 종료하는 버튼
						Button("Done") {
							convertPencilKitViewToImage()
							viewModel.isShowingView = false
						}
					}
					.padding()
					Spacer()
				}
			}
		}
		.onAppear {
			viewModel.canvasView.drawing = PKDrawing()
		}
    }
	
	// PencilKit 뷰를 변환하는 함수
	func convertPencilKitViewToImage() {
		if let image = viewModel.canvasView.asImage() {
			viewModel.drawing = image
		}
	}
}

struct DrawingView: UIViewRepresentable {
	@Binding var canvasView: PKCanvasView
	@Binding var selectedColor: Color
	
	func makeUIView(context: Context) -> some PKCanvasView {
		// 캔버스에서 모든 입력을 허용
		canvasView.drawingPolicy = .anyInput
		// 초기 그리기 도구를 검정색, 두께 5.0 펜으로 설정
		canvasView.tool = PKInkingTool(PKInkingTool.InkType.pen, color: .black, width: 5.0)
		return canvasView
	}
	
	func updateUIView(_ uiView: UIViewType, context: Context) {
		uiView.tool = PKInkingTool(PKInkingTool.InkType.pen, color: UIColor(selectedColor), width: 5.0)
	}
}

#Preview {
    DrawView()
		.environmentObject(ViewModel())
}
