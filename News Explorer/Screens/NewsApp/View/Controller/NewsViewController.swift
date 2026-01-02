//
//  NewsViewController.swift
//  News Explorer
//
//  Created by Rashed Pervez on 2/1/26.
//

//import UIKit
//
//class NewsViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }
//
//
//}

import UIKit

class NewsViewController: UIViewController {
    
    private var viewModel = NewsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
}

extension NewsViewController {
    
    func configuration() {
        initViewModel()
        observeEvent()
    }
    
    func initViewModel() {
        viewModel.fetchNews()
    }
    
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }

            switch event {
            case .loading:
                // Indicator show
                print("Product loading....")
            case .stopLoading:
                    //Hide indicator
                print("Stop loading...")
            case .dataLoaded:
                print("Data loaded...")
                DispatchQueue.main.async {
                    // UI Main works well
                    //self.productTableView.reloadData()
                }
            case .error(let error):
                print(error ?? "error found")
//            case .newProductAdded(let newProduct):
//                print(newProduct)
            }
        }
    }
    
    
}
