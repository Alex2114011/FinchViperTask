//
//  ThemeProvider.swift
//  FinchViperTask
//
//  Created by Alex on 15.11.2021.
//

import UIKit

public enum ThemeProvider {

    public enum DarkStyle {

        public static let label: UIColor = {
                    if #available(iOS 13.0, *) {
                        return UIColor.label
                    } else {
                        return .black
                    }
                }()

        public static var blackViewColor: UIColor = {
            if #available(iOS 13, *) {
                return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                    if UITraitCollection.userInterfaceStyle == .dark {
                        // Return the color for Dark Mode
                        return UIColor(named: "blackViewColor")!
                    } else {
                        // Return the color for Light Mode
                        return UIColor.white
                    }
                }
            } else {
                // Return a fallback color for iOS 12 and lower.
                return UIColor.white
            }
        }()

        public static var greyViewColor: UIColor = {
            if #available(iOS 13, *) {
                return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                    if UITraitCollection.userInterfaceStyle == .dark {
                        // Return the color for Dark Mode
                        return UIColor(named: "grayViewColor")!
                    } else {
                        // Return the color for Light Mode
                        return UIColor.white
                    }
                }
            } else {
                // Return a fallback color for iOS 12 and lower.
                return UIColor.white
            }
        }()

        public static var placeHolderColor: UIColor = {
            if #available(iOS 13, *) {
                return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                    if UITraitCollection.userInterfaceStyle == .dark {
                        // Return the color for Dark Mode
                        return UIColor(named: "placeHolderNightColor")!
                    } else {
                        // Return the color for Light Mode
                        return UIColor(named: "placeHolderDayColor")!
                    }
                }
            } else {
                // Return a fallback color for iOS 12 and lower.
                return UIColor(named: "placeHolderDayColor")!
            }
        }()

        public static var borderColor: UIColor = {
            if #available(iOS 13, *) {
                return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                    if UITraitCollection.userInterfaceStyle == .dark {
                        // Return the color for Dark Mode
                        return UIColor.clear
                    } else {
                        // Return the color for Light Mode
                        return UIColor(named: "dayBorderColor")!
                    }
                }
            } else {
                // Return a fallback color for iOS 12 and lower.
                return UIColor(named: "dayBorderColor")!
            }
        }()
    }
}
// swiftlint:disable identifier_name
public let Style = ThemeProvider.self
