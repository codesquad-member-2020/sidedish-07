//
//  StringRegex.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/28.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import Foundation

extension String{
    func filterRegex(_ regex: String) -> String {
        guard let regex = try? NSRegularExpression(pattern: regex) else { return "" }
        guard let result = regex.firstMatch(in: self, options: .anchored, range: NSRange(self.startIndex..., in: self)) else {
            return ""
        }
        return self.replacingOccurrences(of: self[Range(result.range, in: self)!], with: "")
    }
}
