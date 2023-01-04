//
//  WriteVC.swift
//  HARA
//
//  Created by 김담인 on 2023/01/02.
//

import UIKit
import SnapKit
import Then

class WriteVC: UIViewController {
    
    // MARK: - Properties
    /// background에 Image 넣기
    private let background = UIImageView().then {
        $0.image = UIImage(named: "background")
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .red
    }
    
    private let closeButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "icn_close"), for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "고민작성하기"
        $0.font = .systemFont(ofSize: 16.adjustedW, weight: .semibold)
    }
    
    private let animateView = UIView().then{
        $0.backgroundColor = .clear
    }
    
    lazy var pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    /// pageView에 사용될 5개 VC 선언
    lazy var vc1 = FirstWriteStepView()
    lazy var vc2 = SecondWriteStepView()
    lazy var vc3 = ThirdWriteStepView()
    lazy var vc4 = FourthWriteStepView()
    lazy var vc5 = FifthWriteStepView()
    
    lazy var viewList: [UIViewController] = {
        return [vc1, vc2, vc3, vc4, vc5]
    }()
    
    var currentPage: Int {
        guard let vc = pageViewController.viewControllers?.first else { return 0 }
            return viewList.firstIndex(of: vc) ?? 0
    }
    
    private let prevButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "prevBtn"), for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    private let nextButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "nextBtn"), for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .clear
        enabledArrowBtn()
        setLayout()
        setPress()
        setupDelegate()
        if let firstVC = viewList.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - Function
    private func setPress() {
        closeButton.press {
            if self.navigationController == nil{
                self.dismiss(animated: true, completion: nil)
            }
            self.navigationController?.dismiss(animated: true)
        }
        prevButton.press {
            let prevPage = self.currentPage - 1
            /// 화면 이동 (지금 페이지에서 -1 페이지로 setView 합니다.)
            self.pageViewController.setViewControllers([self.viewList[prevPage]], direction: .reverse, animated: true)
            /// 버튼눌렸을 때 페이지 변경 애니메이션 적용
            self.enabledArrowBtn()
            self.progressBarAnimate()
        }
        nextButton.press {
            let nextPage = self.currentPage + 1
            /// 화면 이동 (지금 페이지에서 +1 페이지로 setView 합니다.)
            self.pageViewController.setViewControllers([self.viewList[nextPage]], direction: .forward, animated: true)
            /// 버튼눌렸을 때 페이지 변경 애니메이션 적용
            self.enabledArrowBtn()
            self.progressBarAnimate()
        }
    }
    
    private func setupDelegate() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }
    
    /// 페이지 이동 버튼 제어 해주는 함수
    private func enabledArrowBtn() {
        if currentPage == 0 {
            prevButton.layer.isHidden = true
        } else if currentPage == 4 {
            nextButton.layer.isHidden = true
        } else {
            prevButton.layer.isHidden = false
            nextButton.layer.isHidden = false
            nextButton.isEnabled = true
            prevButton.isEnabled = true
        }
    }
    
    private func progressBarAnimate() {
        UIView.animate(withDuration: 0.1, animations: {
            self.animateView.alpha = 1
            self.animateView.backgroundColor = .hBlue4
        })
        UIView.animate(withDuration: 0.9, animations: {
            self.animateView.alpha = 1
            self.animateView.backgroundColor = .clear
        })
    }
}

// MARK: - Layout
extension WriteVC{
    
    private func setLayout(){
        self.view.insertSubview(background, at: 0)
        
        background.snp.makeConstraints{
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        view.addSubViews([closeButton, titleLabel])
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.view.addSubviews([prevButton, nextButton, animateView])
        
        
        closeButton.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(13.adjustedH)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(16.adjustedW)
            $0.width.equalTo(24.adjustedW)
            $0.height.equalTo(24.adjustedH)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(15)
            $0.centerX.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        animateView.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(16.adjustedH)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(4.adjustedH)
        }
        
        pageViewController.view.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(16.adjustedH)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        pageViewController.didMove(toParent: self)
        
        prevButton.snp.makeConstraints{
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(35.adjustedW)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-60.adjustedH)
            $0.width.equalTo(10.adjustedW)
            $0.height.equalTo(20.adjustedH)
        }
        
        nextButton.snp.makeConstraints{
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-35.adjustedW)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-60.adjustedH)
            $0.width.equalTo(10.adjustedW)
            $0.height.equalTo(20.adjustedH)
        }
    }
}

// MARK: - UIPageViewControllerDataSource, UIPageViewControllerDelegate
extension WriteVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        progressBarAnimate()
        guard let index = viewList.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return viewList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        progressBarAnimate()
        guard let index = viewList.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == viewList.count {
            return nil
        }
        return viewList[nextIndex]
    }
    
    /// 버튼 클릭시에만 enable을 적용되는 것을 방지하기 위해, page를 스크롤해서 이동시킬 때에서 enable효과를 주기 위한 "didFinishAnimating"
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        enabledArrowBtn()
        progressBarAnimate()
    }
}

extension WriteVC: UITextFieldDelegate {
    /// ✅ textField 에서 편집을 시작한 후
    func textFieldDidBeginEditing(_ textField: UITextField) {
        /// 키보드 업
        textField.becomeFirstResponder()
        /// 입력 시 textField 를 강조하기 위한 테두리 설정
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.red.cgColor
    }
}





