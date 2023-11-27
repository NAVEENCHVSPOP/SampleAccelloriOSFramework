//
//  FrameworkBtn.swift
//  SampleFramework
//
//  Created by Admin on 20/11/23.
//

import UIKit

public class FrameworkBtn: UIButton {

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    // MARK: - Private Methods

    public func setupButton() {
        // Customize the appearance of your button
        setTitleColor(.white, for: .normal)
        backgroundColor = .blue
        layer.cornerRadius = 8.0
        // Add any other customizations or event handlers as needed
    }
}
