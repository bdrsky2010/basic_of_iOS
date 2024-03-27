//
//  ImageDocDemoDocument.swift
//  ImageDocDemo
//
//  Created by Minjae Kim on 12/26/23.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var exampleText: UTType {
        UTType(importedAs: "com.ios3.image")
    }
}

struct ImageDocDemoDocument: FileDocument {
	var image: UIImage = UIImage()
	
    init() {
		if let image = UIImage(named: "test") {
			self.image = image
		}
    }

    static var readableContentTypes: [UTType] { [.exampleText] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
			  let decodedImage: UIImage = UIImage(data: data)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        image = decodedImage
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
		let data = image.pngData()!
        return .init(regularFileWithContents: data)
    }
}
