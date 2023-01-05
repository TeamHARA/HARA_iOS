//
//  StorageVC.swift
//  HARA
//
//  Created by 누리링 on 2023/01/05.
//

import UIKit
import SnapKit
import Moya
import Then


class StorageVC: UIViewController {
    
    private let segmentedControl = UnderlineSegmentedControl(items: ["혼자 고민", "함께 고민"])
    
    private let worriedAloneVC = UIViewController().then {_ in
        let vc = UIViewController()
        vc.view.backgroundColor = .hBlue1
    }
    
//    self.addchild(vc1) - 뷰컨 안에 뷰컨 넣는 방법
    
    private let worriedTogetherVC = UIViewController().then {_ in
        let vc = UIViewController()
        vc.view.backgroundColor = .hBlue2
    }

    private let haraIcon = UIButton().then {
        $0.setImage(UIImage(named: "storage_logo"), for: .normal)
        
    }
    private let bellButton = UIButton().then {
        $0.setImage(UIImage(named: "storage_Bell"), for: .normal)
    }
    private let setting = UIButton().then {
        $0.setImage(UIImage(named: "storage_setting_icon"), for: .normal)
    }
    private let oneclickButton = UIButton().then {
        $0.setImage(UIImage(named: "strorage_oneclick_btn"), for: .normal)
        $0.tintColor = .gray
    }
    
    
    private lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        vc.setViewControllers([self.dataViewControllers[0]], direction: .forward, animated: true)
        vc.delegate = self
        vc.dataSource = self
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        return vc
    }()
    
    var dataViewControllers: [UIViewController] {
        [self.worriedAloneVC, self.worriedTogetherVC]
    }
    
    var currentPage: Int = 0 {
        didSet{
            print(oldValue, self.currentPage)
            let direction: UIPageViewController.NavigationDirection = oldValue <= self.currentPage ? .forward : .reverse
            self.pageViewController.setViewControllers([dataViewControllers[self.currentPage]], direction: direction, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setSegmentedControl()
        setLayout()
    }
}


extension StorageVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = self.dataViewControllers.firstIndex(of: viewController), index - 1 >= 0 // 만약, '(현재 viewcontroller의 index 번호) - 1' 이 0보다 크거나 같다면~
        else { return nil }
        return self.dataViewControllers[index - 1] // dataViewController 배열의 index 번호에서 1을 빼준다.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = self.dataViewControllers.firstIndex(of: viewController), index + 1 < self.dataViewControllers.count // 만약, '(현재 viewcontroller의 index 번호) + 1' 이 0보다 작다면~
        else { return nil }
        return self.dataViewControllers[index + 1] // dataViewController 배열의 index 번호에서 1을 더해준다.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool,
    previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewController = pageViewController.viewControllers?[0],
              let index = self.dataViewControllers.firstIndex(of: viewController)
        else { return }
        self.currentPage = index
        self.segmentedControl.selectedSegmentIndex = index
      
    }
}

extension StorageVC {
    
    private func setLayout(){
        
        [haraIcon, bellButton, setting, oneclickButton].forEach {
            view.addSubview($0)
        }
        
        
        self.view.addSubview(self.segmentedControl)
        self.view.addSubview(self.pageViewController.view)
        
        haraIcon.snp.makeConstraints{
            $0.top.equalTo(55.4.adjustedH)
            $0.leading.equalTo(45.adjustedW).offset(17)
            $0.width.equalTo(45.8)
            $0.height.equalTo(52)
        }
        bellButton.snp.makeConstraints{
            $0.top.equalTo(70.adjustedH)
            $0.trailing.equalTo(44.adjustedW).inset(47)
        }
        setting.snp.makeConstraints{
            $0.top.equalTo(70.adjustedH)
            $0.trailing.equalTo(44.adjustedW).inset(18.5)
        }
        oneclickButton.snp.makeConstraints{
            $0.top.equalTo(haraIcon.snp.bottom).offset(10)
            $0.trailing.equalTo(2.adjustedW).inset(17)
        }

        segmentedControl.snp.makeConstraints{
            $0.top.equalTo(oneclickButton.snp.bottom).offset(8)
            $0.trailing.equalTo(2.adjustedW).inset(17)
            $0.leading.equalTo(2.adjustedW).inset(17)
            $0.height.equalTo(49)
        }
        
        pageViewController.view.snp.makeConstraints{
            $0.top.equalTo(segmentedControl.snp.bottom)
            $0.bottom.equalToSuperview().offset(-50)
            $0.trailing.equalTo(2.adjustedW).inset(17)
            $0.leading.equalTo(2.adjustedW).inset(17)
        }
 
    }
    
    private func setSegmentedControl(){
        // 현재 페이지 index 번호에 해당하는 segmentedcontrol이 아닐 때(for: .normal),
        self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.hBlue3,
                                                      .font: UIFont.haraH1Sb16], for: .normal)
        // 현재 페이지 index 번호에 해당하는 segmentedControl일 때(for: .selected),
        self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.hBlue1,
                                                      .font: UIFont.haraH1Sb16], for: .selected)
        // 페이지가 변경되어 index값이 달라졌을 때,
        self.segmentedControl.addTarget(self, action: #selector(changeValue(control:)), for: .valueChanged)
        self.segmentedControl.selectedSegmentIndex = 0
        self.changeValue(control: self.segmentedControl)
    }
    @objc private func changeValue(control: UISegmentedControl) {
        // currentPage 변수에 현재 선택된 Segmentcontrol의 index를 넣어줌 -> pageViewController와 index 번호 통일
        self.currentPage = control.selectedSegmentIndex
    }
}
