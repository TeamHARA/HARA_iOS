//
//  HaraTabBarController.swift
//  HARA
//
//  Created by 김담인 on 2022/12/27.
//

import UIKit
import SnapKit
import Then

final class HaraTabBarController: UITabBarController {

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
        vc.tabBarItem.setBadgeTextAttributes([NSAttributedString.Key.font: UIFont.haraB1Sb14], for: .normal)
        return vc
    }

    /// TabBarItem을 지정하는 메서드
    private func setTabBar() {
        let togetherTab = makeTabVC(vc: BaseNC(rootViewController: TogetherVC()), tabBarTitle: "함께해라", tabBarImg:"together_tab_icon", tabBarSelectedImg: "together_tab_icon")
        togetherTab.tabBarItem.tag = 0

        let writeTab = makeTabVC(vc: BaseNC(rootViewController: WriteVC()), tabBarTitle: "", tabBarImg: "write_tab_icon", tabBarSelectedImg: "write_tab_icon")
        writeTab.tabBarItem.tag = 1
        writeTab.tabBarItem.imageInsets = UIEdgeInsets(top: -62, left: 0, bottom: 12, right: 0)

        let storageTab = makeTabVC(vc: BaseNC(rootViewController: StorageVC()), tabBarTitle: "보관함", tabBarImg: "storage_tab_icon", tabBarSelectedImg: "storage_tab_icon")
        storageTab.tabBarItem.tag = 2

        let tabs = [togetherTab, writeTab,storageTab ]
        self.setViewControllers(tabs, animated: false)
    }

    private func setTabBarItemStyle() {
        /// clearShadow 없어야 backgroundView 적용됨
//        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 12)
//
//        let tabBarAppearance = UITabBarAppearance()
//        let tabBarItemAppearance = UITabBarItemAppearance()
//
//        tabBarItemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black as Any]
//        tabBarItemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red as Any ]
//
//        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
//        tabBar.standardAppearance = tabBarAppearance
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
        let height = self.view.safeAreaInsets.bottom + 72
        
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
        let na = WriteVC()
        self.navigationController?.pushViewController(na, animated: true)
    }
}

// MARK: - UITabBarControllerDelegate
/// 선택된 탭바의 Index를 tagNumber 변수에 저장하여 +버튼을 누르더라도 rootViewController가 변함이 없게끔 해줌
extension HaraTabBarController: UITabBarControllerDelegate {
    private func setDelegate() {
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController.tabBarItem.tag == 1 {
            let writeVC = WriteVC()
            writeVC.modalPresentationStyle = .overFullScreen
            self.present(writeVC, animated: true, completion:nil)
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


