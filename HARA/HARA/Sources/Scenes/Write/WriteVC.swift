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
        $0.backgroundColor = .clear
    }
    
    private let closeButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "closeBtn"), for: .normal)
        $0.contentMode = .scaleToFill
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
    lazy var vc1 = FirstWriteStepVC()
    lazy var vc2 = SecondWriteStepVC()
    lazy var vc3 = ThirdWriteStepVC()
    lazy var vc4 = FourthWriteStepVC()
    lazy var vc5 = FifthWriteStepVC()
    
    lazy var viewList: [UIViewController] = {
        return [vc1, vc2, vc3, vc4, vc5]
    }()
    
    var currentPage: Int {
        guard let vc = pageViewController.viewControllers?.first else { return 0 }
            return viewList.firstIndex(of: vc) ?? 0
    }
    
    lazy var toastMessage = ToastMessageVC()
    
    private let prevButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "prevBtn"), for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    private let nextButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "nextBtn"), for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    private let uploadButton = UIButton().then {
        $0.backgroundColor = .hBlue4
        $0.layer.cornerRadius = 25
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.hBlue3.cgColor
        $0.titleLabel?.font = .haraH1Sb16
        $0.setTitle("업로드하기", for: .normal)
        $0.setTitleColor(.hBlue3, for: .normal)
        $0.isUserInteractionEnabled = false
    }
    
    private lazy var writeRequest: WriteRequest = WriteRequest(title: "안녕?", content: "힘들지 코딩", categoryId: 2, options: options)
    
    private lazy var options: [WriteRequest.Option] = [WriteRequest.Option(title: "1번 선택지", advantage: "pros", disadvantage: "cons", image: "", hasImage: false), WriteRequest.Option(title: "2번 선택지", advantage: "pros", disadvantage: "cons", image: "", hasImage: false)]
//    options.append(WriteRequest.Option(title: "1번 선택지", advantage: "", disadvantage: "", image: "", hasImage: false)])[
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .clear
        /// 버튼 동작 관련 delegate
        vc5.delegate = self
        vc2.titledelegate = vc3
        
        /// 서버 연결 관련 delegate
        vc1.serverVc1Delegate = self
        
        /// private Func
        disableArrowButton()
        setLayout()
        setPress()
        setupDelegate()
        setFirstPageView()
        configNextButtonLogic()
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
            self.disableArrowButton()
            self.makeProgressBarAnimate()
        }
        nextButton.press {
            let nextPage = self.currentPage + 1
            /// 화면 이동 (지금 페이지에서 +1 페이지로 setView 합니다.)
            self.pageViewController.setViewControllers([self.viewList[nextPage]], direction: .forward, animated: true)
            /// 버튼눌렸을 때 페이지 변경 애니메이션 적용
            self.disableArrowButton()
            self.makeProgressBarAnimate()
            self.vc3.prosConsCV.reloadData()
        }
        uploadButton.press {[self] in
            toastMessage.modalPresentationStyle = .overFullScreen
            self.present(toastMessage, animated: true, completion:nil)
        }
        toastMessage.cancelButton.press {
            self.toastMessage.dismiss(animated: true, completion: nil)
        }
        toastMessage.acceptButton.press {
            self.toastMessage.dismiss(animated: true, completion: {self.dismiss(animated: true)})
            self.postWriteAloneList(worryData: self.writeRequest)
        }
    }
    
    private func setupDelegate() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }
    
    /// 페이지 이동 버튼 제어 해주는 함수
    private func disableArrowButton() {
        if currentPage == 0 {
            prevButton.isHidden = true
            nextButton.isEnabled = false
        }else if currentPage == 1 {
            nextButton.isEnabled = false
            prevButton.isHidden = false
        }else if currentPage == 3 {
            nextButton.isEnabled = false
            prevButton.isHidden = false
        }else if currentPage == 4 {
            nextButton.isHidden = true
        }else {
            prevButton.isHidden = false
            nextButton.isHidden = false
//            nextButton.isEnabled = true
//            prevButton.isEnabled = true
        }
    }
    
    private func makeProgressBarAnimate() {
        UIView.animate(withDuration: 0.1, animations: {
            self.animateView.alpha = 1
            self.animateView.backgroundColor = .hBlue4
        })
        UIView.animate(withDuration: 0.9, animations: {
            self.animateView.alpha = 1
            self.animateView.backgroundColor = .clear
        })
    }
    
    private func setFirstPageView() {
        if let firstVC = viewList.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    private func configNextButtonLogic() {
        vc1.checkVc1Delegate = self
        vc2.checkVc2Delegate = self
        vc4.checkVc4Delegate = self
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
        pageViewController.view.addSubviews([prevButton, uploadButton, nextButton, animateView])
        
        
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
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-24.adjustedH)
            $0.width.equalTo(10.adjustedW)
            $0.height.equalTo(20.adjustedH)
        }
        
        uploadButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(prevButton)
            $0.width.equalTo(210.adjustedW)
            $0.height.equalTo(46.adjustedH)
        }
        
        nextButton.snp.makeConstraints{
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-35.adjustedW)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-24.adjustedH)
            $0.width.equalTo(10.adjustedW)
            $0.height.equalTo(20.adjustedH)
        }
    }
}

// MARK: - UIPageViewControllerDataSource, UIPageViewControllerDelegate
extension WriteVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        makeProgressBarAnimate()
        guard let index = viewList.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return viewList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        makeProgressBarAnimate()
        guard let index = viewList.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == viewList.count {
            return nil
        }
        self.vc3.prosConsCV.reloadData()
        return viewList[nextIndex]
    }
    
    /// 버튼 클릭시에만 enable을 적용되는 것을 방지하기 위해, page를 스크롤해서 이동시킬 때에서 enable효과를 주기 위한 "didFinishAnimating"
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        disableArrowButton()
        makeProgressBarAnimate()
    }
}

// MARK: - UITextFieldDelegate
extension WriteVC: UITextFieldDelegate {
    /// ✅ textField 에서 편집을 시작한 후
    func textFieldDidBeginEditing(_ textField: UITextField) {
        /// 키보드 업
        textField.becomeFirstResponder()
        /// 입력 시 textField 를 강조하기 위한 테두리 설정
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.red.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - UITextViewDelegate
extension WriteVC: UITextViewDelegate {
    /// ✅ textField 에서 편집을 시작한 후
    func textViewDidBeginEditing(_ textView: UITextView) {
        /// 키보드 업
        textView.becomeFirstResponder()
        /// 입력 시 textField 를 강조하기 위한 테두리 설정
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.red.cgColor
    }
    
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
}

// MARK: - SendIsclickedDelegate
/// 5번째 페이지에서 버튼이 선택되었을 때 업로드 버튼 활성화
extension WriteVC: SendIsclickedDelegate{
    func SendIsclicked(alone: Bool, everyone: Bool) {
        if alone == true || everyone == true{
            /// 1.  업로드 버튼 활성화
            uploadButton.isUserInteractionEnabled = true
            /// 2.  버튼 디자인 변경
            uploadButton.setTitleColor(.white, for: .normal)
            uploadButton.backgroundColor = .hBlue1
            uploadButton.layer.borderColor = UIColor.hBlue1.cgColor
        }
        else{
            // 1. 업로드 버튼 비활성화
            uploadButton.isUserInteractionEnabled = false
            // 2. 버튼 디자인 변경
            uploadButton.setTitleColor(.hBlue3, for: .normal)
            uploadButton.backgroundColor = .clear
            uploadButton.layer.borderColor = UIColor.hBlue3.cgColor
        }
    }
}

// MARK: - checkVc1Delegate
extension WriteVC: CheckVc1Delegate{
    /// 첫번째 stepView에서 textfield 및 textView가 채워져 있어야지만 다음 버튼 활성화
    func checkText(checkTextfield: Bool, checkTextView: Bool) {
        if currentPage == 0 {
            if checkTextfield == true && checkTextView == true{
                nextButton.isEnabled = true
            }
            else {
                nextButton.isEnabled = false
            }
        }
    }
}

// MARK: - checkVc2Delegate
extension WriteVC: CheckVc2Delegate{
    /// 두번째 stepView에서 각 옵션별 textfield가 채워져 있어야지만 다음 버튼 활성화
    func checkText(checkBaseOption: Bool, checkAddOption: Bool, isButtonClicked: Bool) {
        if currentPage == 1 {
            if checkBaseOption == true && checkAddOption == true && isButtonClicked == true{
                nextButton.isEnabled = true
            }
            else {
                nextButton.isEnabled = false
            }
        }
    }
}

// MARK: - checkVc4Delegate
extension WriteVC: CheckVc4Delegate{
    /// 네번째 stepView에서 카테고리가 선택되어야지만 다음 버튼 활성화
    func checkCategory(checkTextfield: Bool) {
        if currentPage == 3 {
            if checkTextfield == true {
                nextButton.isEnabled = true
                print(checkTextfield)
            }
            else {
                nextButton.isEnabled = false
                print(checkTextfield)
            }
        }
    }
}

// MARK: - ServerVc1Delegate
extension WriteVC: ServerVc1Delegate{
    /// 첫번째 writeStepVC에서 데이터 전달받는 delegate
    func saveVc1Data(title: String, content: String){
        writeRequest.title = title
        writeRequest.content = content
    }
}

// MARK: - Network
extension WriteVC {
    func postWriteAloneList(worryData: WriteRequest) {
        WriteAPI.shared.postWriteAloneList(param: worryData) { result in
//            guard let a = res.data?[0].id else {return}
            print("결과\(worryData)")
        }
    }
}





