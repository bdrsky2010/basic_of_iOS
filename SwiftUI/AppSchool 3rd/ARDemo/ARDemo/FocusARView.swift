//
//  FocusARView.swift
//  ARDemo
//
//  Created by Minjae Kim on 1/11/24.
//

import SwiftUI
import RealityKit
import FocusEntity
import ARKit

struct FocusARView: View {
	
	@State private var isAddEntityAction = false
	
    var body: some View {
		ZStack(alignment: .bottom) {
			FocusARViewContainer(isAction: $isAddEntityAction)
				.edgesIgnoringSafeArea(.all)
			
			Button {
				isAddEntityAction.toggle()
			} label: {
				Text("Place 3D Model")
					.font(.headline)
					.background(.blue)
					.foregroundStyle(.white)
					.padding()
					.clipShape(.rect(cornerRadius: 10))
			}
			.padding(.bottom, 50)
		}
    }
}

struct FocusARViewContainer: UIViewRepresentable {
	@Binding var isAction: Bool
	
	func makeUIView(context: Context) -> FocusCustomARView {
		return FocusCustomARView()
	}
	
	func updateUIView(_ uiView: FocusCustomARView, context: Context) {
		isAction.toggle()
		uiView.place3DModel()
	}
	
}

class FocusCustomARView: ARView {
	var focusEntity: FocusEntity?
	
	init() {
		super.init(frame: .zero)
		
		self.focusEntity = FocusEntity(on: self, focus: .classic)
		
		let config = ARWorldTrackingConfiguration()
		config.planeDetection = [.horizontal]
		config.environmentTexturing = .automatic
		
		if ARWorldTrackingConfiguration.supportsSceneReconstruction(.meshWithClassification) {
			print("==== meshWithClassification ====")
			config.sceneReconstruction = .meshWithClassification
		}
		
		if ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) {
			print("==== personSegmentationWithDepth ====")
			config.frameSemantics.insert(.personSegmentationWithDepth)
		}
		
		// occlusion
		self.environment.sceneUnderstanding.options.insert(.occlusion)
		
		self.session.run(config)
	}
	
	func place3DModel() {
		guard let focusEntity = self.focusEntity else { return }
		
		let modelEntity = try! ModelEntity.load(named: "toy_drummer_idle" + ".usdz")
		let anchorEntity = AnchorEntity(world: focusEntity.position)
		anchorEntity.addChild(modelEntity)
		self.scene.addAnchor(anchorEntity)
	}
	
	@MainActor required dynamic init?(coder decoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@MainActor required dynamic init(frame frameRect: CGRect) {
		fatalError("init(frame:) has not been implemented")
	}
}

//#Preview {
//    FocusARView()
//}
