//
//  UIImageView+.swift
//  UsersApp
//
//  Created by Hrayr Yeghiazaryan on 19.11.2019.
//  Copyright © 2019 Hrayr Yeghiazaryan. All rights reserved.
//

import Kingfisher
import UIKit

extension UIImageView {
    func setImage(
        with imageURL: URL?,
        placeholder: UIImage? = nil,
        addOptions: KingfisherOptionsInfo? = nil
    ) {
        let options = configureOptions(with: bounds.size) + (addOptions ?? [])
        kf.setImage(with: imageURL,
                    placeholder: placeholder,
                    options: options)
    }
    
    func cancelDownload() {
        kf.cancelDownloadTask()
    }

    private func configureOptions(with size: CGSize) -> KingfisherOptionsInfo {
        return [
            .processor(DownsamplingImageProcessor(size: size)),
            .scaleFactor(UIScreen.main.scale),
            .cacheOriginalImage,
        ]
    }
}
