//
//  Array+Ext.swift
//  SeriesList
//
//  Created by Vitor Costa on 13/01/23.
//

extension Array where Element == String {
	func compactJoin(separator: String = "") -> String {
		compactMap {
			$0.trimmingCharacters(in: .whitespacesAndNewlines)
		}
		.joined(separator: separator)
	}
}
