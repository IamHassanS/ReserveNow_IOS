//
//  HomeViewModal.swift
//  ReserveNow
//
//  Created by trioangle on 27/04/23.
//

import Foundation
class HomeViewModal: BaseViewModel {
    
    
    func getHomeData(params: JSON, _ result : @escaping (Result<BaseModel,Error>) -> Void) {
        ConnectionHandler.shared.getRequest(for: .getHomeData, params: params)
            .responseDecode(to: BaseModel.self, { (json) in
                result(.success(json))
                dump(json)
            }).responseFailure({ (error) in
                AppDelegate.shared.createToastMessage(error)
            })
    }
}
