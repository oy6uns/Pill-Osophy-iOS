//
//  ViewController.swift
//  Pill-osophy
//
//  Created by saint on 2023/05/30.
//

import UIKit
import SnapKit
import Then

final class TabBarController: UITabBarController {

    // MARK: Properties
    private let backgroundView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "tab_background_img")
    }
    
    private var tagNumber: Int = 0
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setTabBar()
        setTabBarItemStyle()
        setTabBarUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setTabBarHeight()
    }
    
    // MARK: - Function
    /// TabBarItem 생성해 주는 메서드
    private func makeTabVC(vc: UIViewController, tabBarTitle: String, tabBarImg: String, tabBarSelectedImg: String) -> UIViewController {

        vc.tabBarItem = UITabBarItem(title: tabBarTitle,
                                     image: UIImage(named: tabBarImg)?.withRenderingMode(.alwaysOriginal),
                                     selectedImage: UIImage(named: tabBarSelectedImg)?.withRenderingMode(.alwaysOriginal))
        vc.tabBarItem.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 0)
        let font = UIFont.systemFont(ofSize: 14)
        vc.tabBarItem.setBadgeTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        return vc
    }

    /// TabBarItem을 지정하는 메서드
    private func setTabBar() {
        let pillListTab = makeTabVC(vc: BaseNC(rootViewController: PillListVC()), tabBarTitle: "약 알아보기", tabBarImg:"pills", tabBarSelectedImg: "pills_selected")
        pillListTab.tabBarItem.tag = 0

        let picTab = makeTabVC(vc: BaseNC(rootViewController: PicVC()), tabBarTitle: "", tabBarImg: "tabbar_btn", tabBarSelectedImg: "tabbar_btn")
        picTab.tabBarItem.tag = 1
        picTab.tabBarItem.imageInsets = UIEdgeInsets(top: -62, left: 0, bottom: 12, right: 0)

        let myPillTab = makeTabVC(vc: BaseNC(rootViewController: MyPillVC()), tabBarTitle: "내 약보관함", tabBarImg: "mypill", tabBarSelectedImg: "mypill_selected")
        myPillTab.tabBarItem.tag = 2

        let tabs = [pillListTab, picTab, myPillTab]
        self.setViewControllers(tabs, animated: false)
    }

    private func setTabBarItemStyle() {
        /// clearShadow 없어야 backgroundView 적용됨
        self.tabBar.tintColor = .black
        tabBar.layer.applyShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 12)
    }

    /// TabBar의 UI를 지정하는 메서드
    private func setTabBarUI() {
        let appearance = self.tabBar.standardAppearance
        appearance.shadowColor = nil
        appearance.shadowImage = nil
        appearance.backgroundImage = nil
        appearance.backgroundEffect = nil
        appearance.backgroundColor = .clear
        self.tabBar.standardAppearance = appearance
        
        self.backgroundView.addShadow(location: .top)
        self.view.addSubviews([backgroundView])
        self.view.bringSubviewToFront(self.tabBar)
    }
    
    /// TabBar의 height을 설정하는 메서드
    private func setTabBarHeight() {
        let height = self.view.safeAreaInsets.bottom + 72.adjustedH
        
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = height
        tabFrame.origin.y = self.view.frame.size.height - height
        
        self.tabBar.frame = tabFrame
        self.tabBar.setNeedsLayout()
        self.tabBar.layoutIfNeeded()
        backgroundView.frame = tabBar.frame
    }
    
    @objc
    private func pushToNewAccount(){
        let na = PicVC()
        self.navigationController?.pushViewController(na, animated: true)
    }
}

// MARK: - UITabBarControllerDelegate
/// 선택된 탭바의 Index를 tagNumber 변수에 저장하여 +버튼을 누르더라도 rootViewController가 변함이 없게끔 해줌
extension TabBarController: UITabBarControllerDelegate {
    private func setDelegate() {
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController.tabBarItem.tag == 1 {
            let picVC = PicVC()
            picVC.modalPresentationStyle = .overFullScreen
            self.present(picVC, animated: true, completion:nil)
            if tagNumber == 0 {
                self.selectedIndex = 0
            }
            else if tagNumber == 2 {
                self.selectedIndex = 2
            }
        }
        else{
            tagNumber = viewController.tabBarItem.tag
        }
    }
}

extension UITabBar {
    /// 기본 그림자 스타일을 초기화해야 커스텀 스타일을 적용할 수 있음
    static func clearShadow() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
    }
}



