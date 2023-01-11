//
//  ThirdStepView.swift
//  HARA
//
//  Created by saint on 2023/01/03.
//

import UIKit
import SnapKit
import Then

class ThirdWriteStepVC: UIViewController{
    
    // MARK: - Properties
    private let background = UIImageView().then {
        $0.image = UIImage(named: "background")
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .clear
    }
    
    lazy var navigationView = UIView().then{
        $0.backgroundColor = .hBlue4
    }
    
    lazy var progressView = UIView().then{
        $0.backgroundColor = .hBlue1
    }
    
    /// 배열 원소의 순서를 바꿔주기 위한 Temp 변수
    private var changeValue: String = ""
    /// 배열 원소의 true, false를 확인하고 바꿔주기 위한 bool type Temp 변수
    private var changeBool: Bool = true
    
    /// 2번째 stepView에서 데이터를 받아올 때, 제목이 있는 Cell 만 탐색해주는 변수
    private var cvcCount: Int = 4
    
    private let questionLabel = UILabel().then{
        $0.numberOfLines = 2
        let normalString1 = NSAttributedString(string: "선택지의\n", attributes: [
            .font: UIFont.haraM1M24])
        let boldString = NSAttributedString(string: "장단점", attributes: [
            .font: UIFont.haraM1B24])
        let normalString2 = NSAttributedString(string: "을 적어보세요.", attributes: [
            .font: UIFont.haraM1M24])
        
        let title = normalString1 + boldString + normalString2
        $0.attributedText = title
    }
    
    private let tipLabel = UILabel().then{
        $0.text = "장단점은 스킵할 수 있어요."
        $0.font = .haraB3R14
        $0.textColor = .hGray2
    }
    
    private let flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
    }
    
    lazy var prosConsCV = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then{
        $0.backgroundColor = .clear
        $0.delegate = self
        $0.dataSource = self
        $0.showsVerticalScrollIndicator = false

    }
    
    private var prosConsTitleArray: [String] = []
    private var zeroCheckArray: [Bool] = []
    
    final let listLineSpacing: CGFloat = 14.adjustedH
    final let listInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 230, right: 0)
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setLayout()
        registerCV()
        /// 키보드 관련 함수
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShown(_:)),name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillBeHidden(_:)),name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Functions
    private func registerCV() {
        prosConsCV.register(ProsConsCVC.self,
                                forCellWithReuseIdentifier: ProsConsCVC.classIdentifier
        )
    }
    /// 키보드가 보일때 화면을 위로 120 만큼 올린다.
    @objc func keyboardWillShown(_ notificiation: NSNotification) {
      self.view.frame = CGRect(x: 0, y: -75, width: self.view.frame.size.width, height: self.view.frame.size.height)
    }
     
    /// 키보드가 사라질때 화면을 다시 원복한다.
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
      self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
    }
}

// MARK: - Layout
extension ThirdWriteStepVC{
    private func setLayout(){
        view.addSubViews([background, navigationView, progressView, questionLabel, tipLabel,prosConsCV])
        
        background.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        navigationView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(4.adjustedH)
            $0.width.equalTo(UIScreen.main.bounds.size.width)
        }
        
        progressView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(4.adjustedH)
            $0.width.equalTo((UIScreen.main.bounds.size.width/4)*3)
        }
        
        questionLabel.snp.makeConstraints{
            $0.top.equalTo(navigationView.snp.bottom).offset(70.adjustedH)
            $0.leading.equalToSuperview().offset(16.adjustedW)
        }
        
        tipLabel.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(6.adjustedH)
            $0.leading.equalToSuperview().offset(16.adjustedW)
        }
        
        prosConsCV.snp.makeConstraints{
            $0.top.equalTo(tipLabel.snp.bottom).offset(10.adjustedH)
            $0.leading.equalToSuperview().offset(16.adjustedW)
            $0.trailing.equalToSuperview().offset(-16.adjustedW)
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ThirdWriteStepVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 343.adjustedW, height: 153.adjustedH)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return listLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return listInset
    }
}

// MARK: - UICollectionViewDataSource

extension ThirdWriteStepVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cvcCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let prosConsCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProsConsCVC.classIdentifier, for: indexPath)
                as? ProsConsCVC else { return UICollectionViewCell() }
        /// 제목이 빈 string 값이 아닐때만 collectionView에 그려준다
        if prosConsTitleArray[indexPath.row] != ""{
            prosConsCell.optionTitle.text = prosConsTitleArray[indexPath.row]
        }
        return prosConsCell
    }
}

/// 세번째 VC의 배열에 secondStepView에서 넣어둔 데이터들을 받아서 뿌려준다.
// MARK: - optionTitleDelegate
extension ThirdWriteStepVC: optionTitleDelegate{
    func sendOptionTitle(optionTitleArray: [String], arrayOrder: Bool, isZero: [Bool]){
        prosConsTitleArray = optionTitleArray
        zeroCheckArray = isZero
        cvcCount = 0
        
        if arrayOrder == true{
            changeValue = prosConsTitleArray[2]
            prosConsTitleArray[2] = prosConsTitleArray[3]
            prosConsTitleArray[3] = changeValue
            
            changeBool = zeroCheckArray[2]
            zeroCheckArray[2] = zeroCheckArray[3]
            zeroCheckArray[3] = changeBool
        }
        /// 빈칸 확인해주는 함수 나중에 구현 예정
        for x in 0...3{
            if prosConsTitleArray[x] != ""{
                cvcCount += 1
            }
        }
    }
}

