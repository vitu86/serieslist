//
//  Images.swift
//  SeriesList
//
//  Created by Vitor Costa on 09/01/23.
//

import UIKit

struct Images {
	static func get(for key: String) -> UIImage {
		UIImage(named: key) ?? UIImage(named: "NoImage")!
	}
}
