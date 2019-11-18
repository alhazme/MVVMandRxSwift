//
//  ShopTypeViewController.swift
//  Tokopedia
//
//  Created by Mochamad Fariz Al Hazmi on 18/11/19.
//  Copyright © 2019 Mochamad Fariz Al Hazmi. All rights reserved.
//

import UIKit

protocol ShopTypeViewControllerDelegate {
    func shopTypeApply(_ shopTypes: [String])
}

class ShopTypeViewController: UIViewController {

    @IBOutlet var btnReset: UIBarButtonItem!
    @IBOutlet var ivGoldMerchant: UIImageView!
    @IBOutlet var btnGoldMerchant: UIButton!
    @IBOutlet var ivOfficialStore: UIImageView!
    @IBOutlet var btnOfficialStore: UIButton!
    @IBOutlet var btnApply: UIButton!
    
    var delegate: ShopTypeViewControllerDelegate?
    var shopTypes: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        customBackBarButton()
    }
    
    func setupLayout() {
        if (shopTypes.contains("Gold Merchant")) {
            ivGoldMerchant.image = UIImage.init(systemName: "checkmark.square")
        }
        else {
            ivGoldMerchant.image = UIImage.init(systemName: "square")
        }
        
        if (shopTypes.contains("Official Store")) {
            ivOfficialStore.image = UIImage.init(systemName: "checkmark.square")
        }
        else {
            ivOfficialStore.image = UIImage.init(systemName: "square")
        }
    }
    
    func customBackBarButton() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: Selector(("buttonBackAction:")))
    }
    
    @objc func buttonBackAction(_ button: UIBarButtonItem) {
        print("back")
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onTapReset(_ sender: Any) {
        shopTypes.removeAll()
        ivGoldMerchant.image = UIImage.init(systemName: "square")
        ivOfficialStore.image = UIImage.init(systemName: "square")
        print("Reset")
    }
    
    @IBAction func onTapGoldMerchant(_ sender: Any) {
        guard let index = shopTypes.firstIndex(of: "Gold Merchant") else {
            shopTypes.append("Gold Merchant")
            ivGoldMerchant.image = UIImage.init(systemName: "checkmark.square")
            return
        }
        ivGoldMerchant.image = UIImage.init(systemName: "square")
        shopTypes.remove(at: index)
    }
    
    @IBAction func onTapOfficialStore(_ sender: Any) {
        guard let index = shopTypes.firstIndex(of: "Official Store") else {
            shopTypes.append("Official Store")
            ivOfficialStore.image = UIImage.init(systemName: "checkmark.square")
            return
        }
        ivOfficialStore.image = UIImage.init(systemName: "square")
        shopTypes.remove(at: index)
    }
    
    @IBAction func onTapApply(_ sender: Any) {
        print(shopTypes)
        delegate?.shopTypeApply(shopTypes)
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
