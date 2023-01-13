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
    
    // MARK: - Properties
    private let segmentedControl = UnderlineSegmentedControl(items: ["혼자 고민", "함께 고민"])
    
    private let worriedAloneVC = AloneWorriedVC()
    private let worriedTogetherVC = TogetherWorriedVC()
    
    private lazy var segmentedLineView = UIView(frame: CGRect(x: 30, y: 428, width: 343, height: 1)).then{
        $0.backgroundColor = .hBlue3
    }
    
    private let background = UIImageView().then {
        $0.image = UIImage(named: "background")
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .clear
    }
    
    private let storageNavigationView = StorageNavigationView()
    
    private let oneclickButton = UIButton().then {
        $0.setImage(UIImage(named: "strorage_oneclick_btn"), for: .normal)
        $0.tintColor = .gray
    }
    
    private lazy var pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil).then {
        $0.setViewControllers([self.dataViewControllers[0]], direction: .forward, animated: true)
        $0.delegate = self
        $0.dataSource = self
    }
    
    var dataViewControllers: [UIViewController] {
        [self.worriedAloneVC, self.worriedTogetherVC]
    }
    
    var currentPage: Int = 0 {
        didSet{
            let direction: UIPageViewController.NavigationDirection = oldValue <= self.currentPage ? .forward : .reverse
            self.pageViewController.setViewControllers([dataViewControllers[self.currentPage]], direction: direction, animated: true)
        }
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        setSegmentedControl()
        setLayout()
        setPress()
    }
    
    // MARK: - Functions
    private func setPress() {
        let oneSecGameVC = OneSecGameVC()
        oneSecGameVC.modalPresentationStyle = .overFullScreen
        oneclickButton.press {
            self.navigationController?.present(oneSecGameVC, animated: true)
        }
    }
    
    private func setSegmentedControl(){
        /// 현재 페이지 index 번호에 해당하는 segmentedcontrol이 아닐 때(for: .normal),
        self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.hBlue3,
                                                      .font: UIFont.haraH1Sb16], for: .normal)
        /// 현재 페이지 index 번호에 해당하는 segmentedControl일 때(for: .selected),
        self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.hBlue1,
                                                      .font: UIFont.haraH1Sb16], for: .selected)
        /// 페이지가 변경되어 index값이 달라졌을 때
        self.segmentedControl.addTarget(self, action: #selector(changeValue(control:)), for: .valueChanged)
        self.segmentedControl.selectedSegmentIndex = 0
        self.changeValue(control: self.segmentedControl)
    }
    @objc private func changeValue(control: UISegmentedControl) {
        /// currentPage 변수에 현재 선택된 Segmentcontrol의 index를 넣어줌 -> pageViewController와 index 번호 통일
        self.currentPage = control.selectedSegmentIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = self.dataViewControllers.firstIndex(of: viewController), index + 1 < self.dataViewControllers.count /// 만약, '(현재 viewcontroller의 index 번호) + 1' 이 0보다 작다면~
        else { return nil }
        return self.dataViewControllers[index + 1] /// dataViewController 배열의 index 번호에서 1을 더해준다.
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


// MARK: - UIPageViewControllerDataSource, UIPageViewControllerDelegate
extension StorageVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = self.dataViewControllers.firstIndex(of: viewController), index - 1 >= 0
                /// 만약, '(현재 viewcontroller의 index 번호) - 1' 이 0보다 크거나 같다면~
        else { return nil }
        return self.dataViewControllers[index - 1] /// dataViewController 배열의 index 번호에서 1을 빼준다.
    }
}

// MARK: - Layout
extension StorageVC {
    private func setLayout(){
        
        view.addSubviews([background, storageNavigationView, segmentedLineView, oneclickButton])
        self.view.addSubview(self.segmentedControl)
        self.view.addSubview(self.pageViewController.view)
        
        background.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        storageNavigationView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(24.adjustedH)
        }
        
        oneclickButton.snp.makeConstraints{
            $0.top.equalTo(storageNavigationView.snp.bottom).offset(21)
            $0.leading.equalToSuperview().offset(16.adjustedW)
            $0.trailing.equalToSuperview().offset(-16.adjustedW)
            $0.height.equalTo(64.adjustedH)
        }
        
        segmentedControl.snp.makeConstraints{
            $0.top.equalTo(oneclickButton.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(16.adjustedW)
            $0.trailing.equalToSuperview().offset(-16.adjustedW)
            $0.height.equalTo(49)
        }
        
        segmentedLineView.snp.makeConstraints{
            $0.bottom.equalTo(segmentedControl.snp.bottom)
            $0.leading.equalToSuperview().offset(16.adjustedW)
            $0.trailing.equalToSuperview().offset(-16.adjustedW)
            $0.height.equalTo(3)
        }
        
        pageViewController.view.snp.makeConstraints{
            $0.top.equalTo(segmentedControl.snp.bottom)
            $0.bottom.equalToSuperview().offset(-50)
            $0.trailing.leading.equalToSuperview()
        }
    }
}
