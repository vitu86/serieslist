//
//  L10n.swift
//  SeriesList
//
//  Created by Vitor Costa on 09/01/23.
//

import Foundation

struct L10n {
	static func string(for key: String) -> String {
		GetBundle.bundle.localizedString(forKey: key, value: nil, table: nil)
	}
}


private class GetBundle {
	static let bundle = Bundle(for: GetBundle.self)
}
