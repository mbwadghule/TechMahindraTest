//
//  ViewModel.swift
//  Infosys-MachineTest
//
//  Created by Augment Deck Technologies on 05/08/20.
//  Copyright © 2020 Augment Deck Technologies. All rights reserved.
//

import Foundation

class ViewModel {
    var httpUtility = HTTPUtility()
    var itemList: WebItems?

    typealias ComplitionBlock = (WebItems, Bool) -> Void
    func getDataFromApi(apiUrl: String, complitionBlock:@escaping (ComplitionBlock)) {
        if Reachability.isConnectedToNetwork() {
            httpUtility.getApiData(requestUrl: Constants.apiString, resultType: WebItems.self) { Response in
                self.itemList = Response
                complitionBlock(Response, true)
            }
        }
        else {
            complitionBlock(WebItems(title: "", rows: [RowData(title: nil, rowDescription: nil, imageHref: nil)]), false)
        }
    }
    func getNumberOfRows() -> Int {
         itemList?.rows.count ?? 0
    }
}

