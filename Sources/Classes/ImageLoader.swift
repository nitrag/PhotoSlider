//
//  ImageLoader.swift
//  PhotoSlider
//
//  Created by ChangHoon Jung on 2017. 1. 10..
//  Copyright © 2017년 nakajijapan. All rights reserved.
//

import Foundation
import SDWebImage

public protocol ImageLoader: class {
    typealias ProgressBlock = (_ receivedSize: Int, _ totalSize: Int) -> Void
    typealias CompletionBlock = (_ image: UIImage?) -> Void

    func load(
        imageView: UIImageView?,
        fromURL url: URL?,
        progress: @escaping ImageLoader.ProgressBlock,
        completion: @escaping ImageLoader.CompletionBlock)
}

class PhotoSliderSDImageLoader: PhotoSlider.ImageLoader {
    public func load(
        imageView: UIImageView?,
        fromURL url: URL?,
        progress: @escaping PhotoSlider.ImageLoader.ProgressBlock,
        completion: @escaping PhotoSlider.ImageLoader.CompletionBlock)
    {
        imageView?.sd_setImage(
            with: url,
            placeholderImage: nil,
            options: SDWebImageOptions.retryFailed,
            progress: { (receivedSize, totalSize) in
                progress(receivedSize, totalSize)
        }, completed: { (image, _, _, _) in
            completion(image)
        })
    }
}