//
//  LoadingView.swift
//  UsersApp
//
//  Created by Hrayr Yeghiazaryan on 02.12.2019.
//  Copyright © 2019 Hrayr Yeghiazaryan. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    // MARK: - UI
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Initializations

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadView()
    }

    // MARK: - View loading

    private func loadView() {
        loadNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = Asset.Colors.dark.color
        addSubview(contentView)
    }
    
    // MARK: - Public
    
    func startLoading() {
        isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        isHidden = true
        activityIndicator.stopAnimating()
    }
}
