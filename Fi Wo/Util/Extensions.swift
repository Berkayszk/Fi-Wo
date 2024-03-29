//
//  Extensions.swift
//  Fi Wo
//
//  Created by Berkay Sazak on 25.01.2024.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
