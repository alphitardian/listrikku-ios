//
//  UIFontHelper.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 12/05/22.
//

import Foundation
import UIKit

extension UIFont {
    static func preferredFont(for style: TextStyle, weight: Weight) -> UIFont {
        let metrics = UIFontMetrics(forTextStyle: style)
        let desc = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        let font = UIFont.systemFont(ofSize: desc.pointSize, weight: weight)
        return metrics.scaledFont(for: font)
    }
}
