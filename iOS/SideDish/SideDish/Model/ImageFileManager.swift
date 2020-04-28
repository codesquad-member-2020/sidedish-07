//
//  ImageFileManager.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/26.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class ImageFileManager {
    static func saveImage(image: UIImage, name: String) {
        guard let data = image.jpegData(compressionQuality: 1),
            let directory = try? FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as URL else { return }
        try? data.write(to: directory.appendingPathComponent(name))
    }
    
    static func getSavedImage(name: String) -> UIImage? {
        guard let directory = try? FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else { return nil }
        let path = URL(fileURLWithPath: directory.absoluteString).appendingPathComponent(name).path
        let image = UIImage(contentsOfFile: path)
        return image
    }
}
