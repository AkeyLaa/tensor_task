//
//  UIStyleAppearance.swift
//  tensor_task
//
//  Created by Sergey on 01.10.2021.
//

import UIKit

public enum DefaultStyle {

    public enum Colors {
        
        public static let main: UIColor = UIColor(named: "ContactBackground")!
        
        public static let navigationBar: UIColor = {
            return Colors.main
        }()

        public static let doneButton: UIColor = {
            if #available(iOS 13, *) {
                    return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                        if UITraitCollection.userInterfaceStyle == .dark {
                            return .white
                        } else {
                            return Colors.main
                        }
                    }
                } else {
                    return Colors.main
                }
        }()
    }
}
