//
//  ProductListViewController.swift
//  MVVMDesignPattern
//
//  Created by apple on 14/11/24.
//

import UIKit

class ProductListViewController: UIViewController {
    
    @IBOutlet weak var productTableView: UITableView!
    private var viewModel = ProductViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
}

extension ProductListViewController {
    
    func configuration(){
        productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        initViewModel()
        observeEvent()
    }
    
    func initViewModel() {
        viewModel.fetchProducts()
        
    }
    //data binding event obeserve - Communication
    func observeEvent() {
        viewModel.eventHandler = {[weak self] event in
            guard let self else { return }
            
            switch event {
            case .loading:
                //indicator show
                print("Product loading....")
            case .stopLoading:
                //indicator hide
                print("Stop loading...")
            case .dataLoaded:
                print("Data loaded...")
                DispatchQueue.main.async {
                    //UI main works well
                    print("viewModel.products.count",self.viewModel.products.count)
                    self.productTableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }
}


extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = productTableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else{
            return UITableViewCell()
        }
        
//        let /*cell = se/*lf.productTableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductCell*/*/
        let product = viewModel.products[indexPath.row]
        print("dddd",product)
        cell.product = product
        return cell
    }
}
