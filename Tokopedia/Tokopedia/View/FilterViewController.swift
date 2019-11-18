//
//  FilterViewController.swift
//  Tokopedia
//
//  Created by Mochamad Fariz Al Hazmi on 13/11/19.
//  Copyright © 2019 Mochamad Fariz Al Hazmi. All rights reserved.
//

import UIKit
import RangeSeekSlider

protocol FilterViewControllerDelegate {
    func filterProducts(_ minPrice: Int, maxPrice: Int, wholeSale: Bool, shopTypes: [String], official: Bool?, fshop: Int?, start: Int, rows: Int)
}

class FilterViewController: UIViewController {

    @IBOutlet weak var btnClose: UIBarButtonItem!
    @IBOutlet weak var btnReset: UIBarButtonItem!
    @IBOutlet weak var lbMinimum: UILabel!
    @IBOutlet weak var lbMaximum: UILabel!
    @IBOutlet weak var rgPriceSlider: RangeSeekSlider!
    @IBOutlet weak var swWholeSale: UISwitch!
    @IBOutlet weak var btnShopType: UIButton!
    @IBOutlet weak var cvShopType: UICollectionView!
    @IBOutlet weak var btnApply: UIButton!
    
    var delegate: FilterViewControllerDelegate?
    
    var minimumPrice: CGFloat = 100.0
    var maximumPrice: CGFloat = 10000000.0
    var isWholeSale: Bool = false
    var shopTypes: [String] = []
    var official: Bool? = nil
    var fshop: Int? = nil
    var start: Int = 0
    var row = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupLayout()
    }
    
    func setupLayout() {
        setupRangeSlider()
        setupSwitchWholeSale()
        setupCollectionView()
    }
    
    func setupRangeSlider() {
        setupRangePrice(minValue: minimumPrice, maxValue: maximumPrice)
        rgPriceSlider.selectedMinValue = minimumPrice
        rgPriceSlider.selectedMaxValue = maximumPrice
        rgPriceSlider.delegate = self
    }
    
    func setupRangePrice(minValue: CGFloat, maxValue: CGFloat) {
        self.minimumPrice = minValue
        self.maximumPrice = maxValue
        self.lbMinimum.text = "Rp \(Int(self.minimumPrice))"
        self.lbMaximum.text = "Rp \(Int(self.maximumPrice))"
    }
    
    func setupSwitchWholeSale() {
        self.swWholeSale.isOn = self.isWholeSale
    }
    
    func reset() {
        self.swWholeSale.isOn = false
        self.minimumPrice = 100.0
        self.maximumPrice = 10000000.0
        self.isWholeSale = false
        self.shopTypes = []
        self.official = nil
        self.fshop = nil
        self.start = 0
        self.row = 10
    }
    
    @IBAction func onTapClose(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: {
            
        })
    }
    
    @IBAction func onTapReset(_ sender: Any) {
        self.reset()
        self.setupRangePrice(minValue: self.minimumPrice, maxValue: self.maximumPrice)
    }
    
    @IBAction func onSwitchWholeSale(_ sender: Any) {
        self.isWholeSale = swWholeSale.isOn
    }
    
    @IBAction func onTapShopType(_ sender: Any) {
        self.performSegue(withIdentifier: "openShopTypePage", sender: nil)
    }
    
    @IBAction func onTapApply(_ sender: Any) {
        print("isWholeSale \(isWholeSale)")
        print("shopTypes \(shopTypes)")
        print("\(Int(self.minimumPrice))")
        print("\(Int(self.maximumPrice))")
        
        var goldMerchant: Int? = nil
        if (shopTypes.contains("Gold Merchant")) {
            goldMerchant = 2
        }
        var official: Bool? = nil
        if (shopTypes.contains("Official Store")) {
            official = true
        }
        
        delegate?.filterProducts(
            Int(self.minimumPrice),
            maxPrice: Int(self.maximumPrice),
            wholeSale: isWholeSale,
            shopTypes: shopTypes,
            official: shopTypes.contains("Official Store"),
            fshop: goldMerchant,
            start: 0,
            rows: 10)
        self.navigationController?.dismiss(animated: true, completion: {
            
        })
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let identifier = segue.identifier else {
            return
        }
        if (identifier == "openShopTypePage") {
            if let shopTypeViewController = segue.destination as? ShopTypeViewController {
                shopTypeViewController.shopTypes = self.shopTypes
                shopTypeViewController.delegate = self
            }
        }
    }

}

extension FilterViewController: RangeSeekSliderDelegate {
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        self.setupRangePrice(minValue: minValue, maxValue: maxValue)
    }
    
}

extension FilterViewController: ShopTypeViewControllerDelegate {
    
    func shopTypeApply(_ shopTypes: [String]) {
        self.shopTypes = shopTypes
        reloadShopType()
    }
    
}

extension FilterViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ShopTypeCollectionViewCellDelegate {
    
    func setupCollectionView() {
        self.cvShopType.delegate = self
        self.cvShopType.dataSource = self
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = .zero
//        flowLayout.scrollDirection = .horizontal
        self.cvShopType.collectionViewLayout = flowLayout
        
        self.cvShopType.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        self.cvShopType.isPagingEnabled = false
        self.cvShopType.backgroundColor = .white
        self.cvShopType.showsHorizontalScrollIndicator = false
        self.cvShopType.showsVerticalScrollIndicator = false
        
    }
    
    func reloadShopType() {
        self.cvShopType.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopTypes.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom:0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let shopType = self.shopTypes[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopTypeCollectionViewCell", for: indexPath) as! ShopTypeCollectionViewCell
        cell.shopType = shopType
        cell.lbTitle.text = shopType
        cell.delegate = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func closeShopType(_ shopType: String) {
        if let index = shopTypes.firstIndex(of: shopType) {
            self.shopTypes.remove(at: index)
            self.reloadShopType()
        }
    }
    
}
