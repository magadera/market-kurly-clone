//
//  HomeViewController.swift
//  Kurly_Clone
//
//  Created by Vice on 2022/01/10.
//

import UIKit
import Tabman
import Pageboy

class HomeViewController: TabmanViewController {
    
    // 페이징 할 뷰 컨트롤러
    var viewControllers: Array<UIViewController> = []

    // 상단 탭바 들어갈 자리
    @IBOutlet weak var tempView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let kurlyRecommend = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "KurlyRecommendViewController") as! KurlyRecommendViewController
        let newProduct = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "NewProductViewController") as! NewProductViewController
        let best = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "BestViewController") as! BestViewController
        let frugal = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "FrugalShoppingViewController") as! FrugalShoppingViewController
        let specialPrice = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "SpecialPriceViewController") as! SpecialPriceViewController
        
        viewControllers.append(kurlyRecommend)
        viewControllers.append(newProduct)
        viewControllers.append(best)
        viewControllers.append(frugal)
        viewControllers.append(specialPrice)
        
        self.dataSource = self
        
        // Create bar
        let bar = TMBar.ButtonBar()
        settingTabBar(ctBar: bar)   // 함수 추후 구현
        
        // Add to View
        addBar(bar, dataSource: self, at: .custom(view: tempView, layout: nil))

    }
    
    func settingTabBar (ctBar : TMBar.ButtonBar) {
        ctBar.layout.transitionStyle = .snap    // Customize
        // 여백주기
        ctBar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        // 간격
        ctBar.layout.alignment = .centerDistributed
        ctBar.layout.contentMode = .fit
//        ctBar.layout.interButtonSpacing = 35
        
        ctBar.backgroundView.style = .blur(style: .light)
        
        // 선택 / 안선택 색 + font size
        ctBar.buttons.customize { (button) in
            button.tintColor = .gray
            button.selectedTintColor = .purple
            button.font = UIFont.systemFont(ofSize: 16)
            button.selectedFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        }
        
        // 인디케이터 (영상에서 주황색 아래 바 부분)
        ctBar.indicator.weight = .custom(value: 3)
        ctBar.indicator.tintColor = .purple
        ctBar.indicator.overscrollBehavior = .compress
//        ctBar.indicator.contentMode = .scaleAspectFit
    }


}

extension HomeViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        
        // MARK: -Tab 안 글씨들
        switch index {
        case 0:
            return TMBarItem(title: "컬리추천")
        case 1:
            return TMBarItem(title: "신상품")
        case 2:
            return TMBarItem(title: "베스트")
        case 3:
            return TMBarItem(title: "알뜰쇼핑")
        case 4:
            return TMBarItem(title: "특가/혜택")
        default:
            let title = "Page \(index)"
            return TMBarItem(title: title)
        }
        
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        //위에서 선언한 vc array의 count를 반환합니다.
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
}
