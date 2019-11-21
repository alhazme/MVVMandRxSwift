//
//  ViewController.swift
//  Tokopedia
//
//  Created by Mochamad Fariz Al Hazmi on 13/11/19.
//  Copyright © 2019 Mochamad Fariz Al Hazmi. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var filterButton: UIButton!
    
    // View Model
    private let viewModel = ReactiveProductViewModel()
    let disposeBag = DisposeBag()
    let viewWillAppearTrigger = PublishSubject<Void>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupLayout()
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewWillAppearTrigger.onNext(())
    }
    
    func setupLayout() {
        setupNavigationBar()
        setupCollectionView()
    }
    
    func setupNavigationBar() {
        self.navigationItem.title = "Search"
    }
    
    func setupCollectionView() {
    
        self.collectionView.backgroundColor = .lightGray
        
        let width = (UIScreen.main.bounds.width - 24) / 2
        let height = CGFloat(300)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = .zero
        flowLayout.itemSize = CGSize(width: width, height: height)
        self.collectionView.collectionViewLayout = flowLayout
        
        self.collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        self.collectionView.isPagingEnabled = false
        self.collectionView.backgroundColor = .white
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false

    }
    
    func setupViewModel() {
        
        // Mark: INPUT
        let input = ReactiveProductViewModel.Input(
            didLoadTrigger: .just(()),
            willAppear: viewWillAppearTrigger.asObserver().asDriver(onErrorJustReturn: ())
        )
        
        // Mark: OUTPUT
        let output = viewModel.transform(input: input)
        output.productListCellData.drive(
            collectionView.rx.items(
                cellIdentifier: ProductCollectionViewCell.reuseIdentifier, cellType: ProductCollectionViewCell.self
            )
        ) { row, model, cell in
            cell.configureCell(with: model)
        }.disposed(by: disposeBag)
        
    }
    
    func fetchProducts(_ minPrice: Int, maxPrice: Int, wholeSale: Bool, official: Bool?, fshop: Int?, start: Int, rows: Int) {
        viewModel.minimumPrice = minPrice
        viewModel.maximumPrice = maxPrice
        viewModel.wholeSale = wholeSale
        viewModel.official = official
        viewModel.fshop = fshop
        viewModel.start = start
        viewModel.row = rows
        
    }

    @IBAction func filterButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: "openFilterPage", sender: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let identifier = segue.identifier else {
            return
        }
        if (identifier == "openFilterPage") {
            if let navigationController = segue.destination as? UINavigationController {
                if let filterViewController = navigationController.viewControllers.first as? FilterViewController {
                    filterViewController.delegate = self
                    filterViewController.minimumPrice = CGFloat(viewModel.minimumPrice)
                    filterViewController.maximumPrice = CGFloat(viewModel.maximumPrice)
                    filterViewController.isWholeSale = viewModel.wholeSale
                    filterViewController.shopTypes = viewModel.shopTypes
                    filterViewController.official = viewModel.official
                    filterViewController.fshop = viewModel.fshop
                    filterViewController.start = viewModel.start
                    filterViewController.row = viewModel.row
                }
            }
        }
    }
    
}

extension ViewController: FilterViewControllerDelegate {
    
    func filterProducts(_ minPrice: Int, maxPrice: Int, wholeSale: Bool, shopTypes: [String], official: Bool?, fshop: Int?, start: Int, rows: Int) {
        fetchProducts(minPrice, maxPrice: maxPrice, wholeSale: wholeSale, official: official, fshop: fshop, start: start, rows: rows)
    }
    
}
