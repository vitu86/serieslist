//
//  String+HTML.swift
//  SeriesList
//
//  Created by Vitor Costa on 13/12/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import Foundation

extension String {
    func getHTMLText() -> NSAttributedString? {
        guard let valueData = data(using: .utf8) else { return nil }
        return try? NSAttributedString(data: valueData, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
    }
}
