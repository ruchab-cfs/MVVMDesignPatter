//
//  ProductViewModel.swift
//  MVVMDesignPattern
//
//  Created by apple on 14/11/24.
//

import Foundation

final class ProductViewModel{
    
    var products: [Product] = []
    var eventHandler: ((_ event: Event) -> Void)? //data binding closure
    
    func fetchProducts(){
        print("in")
    
        self.eventHandler?(.loading)
        APIManager.shared.fetchProducts { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let products):
                self.products = products
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))                
            }
        }
    }
}

extension ProductViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
