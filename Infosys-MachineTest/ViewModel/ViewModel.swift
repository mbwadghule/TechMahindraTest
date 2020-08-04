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
    var canadaList: WebItems?

    typealias ComplitionBlock = (WebItems, Bool) -> Void
    func getDataFromApi(apiUrl: String, complitionBlock:@escaping (ComplitionBlock)) {
        if Reachability.isConnectedToNetwork() {
            // make api call
            httpUtility.getApiData(requestUrl: Constants.apiString, resultType: WebItems.self) { canadaResponse in
                self.canadaList = canadaResponse
                complitionBlock(canadaResponse, true)
            }
        }
        else {
            complitionBlock(WebItems(title: "", rows: [RowData(title: nil, rowDescription: nil, imageHref: nil)]), false)
        }
    }
    func getNumberOfRows() -> Int {
         canadaList?.rows.count ?? 0
    }
}

