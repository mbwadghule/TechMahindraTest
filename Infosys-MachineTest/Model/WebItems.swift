//
//  WebItems.swift
//  Infosys-MachineTest
//
//  Created by Augment Deck Technologies on 05/08/20.
//  Copyright © 2020 Augment Deck Technologies. All rights reserved.
//

import Foundation
struct WebItems: Decodable {
    let title: String
    let rows: [RowData]
}

struct RowData: Decodable {
    let title, rowDescription: String?
    let imageHref: String?

    enum CodingKeys: String, CodingKey {
        case title
        case rowDescription = "description"
        case imageHref
    }
}
