//
//  SegmentedVC.swift
//  HARA
//
//  Created by 누리링 on 2023/01/04.
//

import UIKit
import SnapKit
import Then

class SegmentedVC: UIViewController {
    
    private let segmentedControl = UnderlineSegmentedControl(items: ["함께 고민", "같이 고민"])
    
    private let vc1: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .hBlue1
        return vc
    }()
    
//    self.addchile(vc1) - 뷰컨 안에 뷰컨 넣는 방법
    
    private let vc2: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .hBlue2
        return vc
    }()

    private lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        vc.setViewControllers([self.dataViewControllers[0]], direction: .forward, animated: true)
        vc.delegate = self
        vc.dataSource = self
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        return vc
    }()
    
    var dataViewControllers: [UIViewController] {
        [self.vc1, self.vc2]
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
        setLayout()
    }
}


extension SegmentedVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
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

extension SegmentedVC {
    
    private func setLayout(){
        
        self.view.addSubview(self.segmentedControl)
        self.view.addSubview(self.pageViewController.view)
        
        segmentedControl.snp.makeConstraints{
            $0.top.equalToSuperview().offset(50)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        pageViewController.view.snp.makeConstraints{
            $0.top.equalTo(segmentedControl.snp.bottom)
            $0.bottom.equalToSuperview().offset(-85)
            $0.leading.trailing.equalToSuperview()
        }
 
    }
    
    private func setSegmentedControl(){
        // 현재 페이지 index 번호에 해당하는 segmentedcontrol이 아닐 때(for: .normal),
        self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray,
                                                      .font: UIFont.systemFont(ofSize: 16, weight: .medium)], for: .normal)
        // 현재 페이지 index 번호에 해당하는 segmentedControl일 때(for: .selected),
        self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.purple,
                                                      .font: UIFont.systemFont(ofSize:16, weight: .semibold)], for: .selected)
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
