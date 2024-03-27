//
//  Usdz3DView.swift
//  ARDemo
//
//  Created by Minjae Kim on 1/11/24.
//

import SwiftUI
import RealityKit

struct Usdz3DView: View {
	
	let modelNames = ["chair_swan", "cup_saucer_set", "fender_stratocaster", "gramophone", "robot_walk_idle", "teapot", "toy_biplane_idle", "toy_drummer_idle"]
	@State private var selectedModelIdex = 0
	
    var body: some View {
		VStack {
			// 선택된 모델이 포함된 AR 뷰 컨테이너
			Usdz3DViewContainer(modelName: modelNames[selectedModelIdex])
				.edgesIgnoringSafeArea(.all)
			
			Picker("Select Model", selection: $selectedModelIdex) {
				ForEach(0..<modelNames.count, id: \.self) { index in
					Image(modelNames[index])
						.resizable()
						.frame(width: 50, height: 50)
						.tag(index)
				}
			}
			.pickerStyle(SegmentedPickerStyle())
		}
    }
}

struct Usdz3DViewContainer: UIViewRepresentable {
	let modelName: String
	
	func makeUIView(context: Context) -> ARView {
		let arView = ARView(frame: .zero)
		return arView
	}
	
	func updateUIView(_ uiView: ARView, context: Context) {
		// 기존 앵커를 제거(초기화)
		uiView.scene.anchors.removeAll()
		
		// 에셋 폴더에서 모델 로드
		let modelEntity = try! ModelEntity.loadModel(named: modelName + ".usdz")
		// 앵커 엔티티를 생성하고 모델을 추가
		let anchorEntity = AnchorEntity()
		anchorEntity.addChild(modelEntity)
		
		// 앵커 엔티티의 위치를 카메라 앞 0.5미터로 설정
		anchorEntity.position = [0, 0, -0.5]
		
		// 장면에 앵커 엔티티 추가
		uiView.scene.addAnchor(anchorEntity)
	}
	
}

//#Preview {
//    Usdz3DView()
//}
