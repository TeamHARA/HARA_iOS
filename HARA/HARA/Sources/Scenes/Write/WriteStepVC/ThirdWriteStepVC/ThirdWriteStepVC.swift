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
    }
    
    private var prosConsTitleArray: [String] = []
    private var zeroCheckArray: [Bool] = []
    
    final let listLineSpacing: CGFloat = 14.adjustedH
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        print("델리\(prosConsTitleArray)")
        setLayout()
        registerCV()
    }
    
    // MARK: - Functions
    private func registerCV() {
        prosConsCV.register(ProsConsCVC.self,
                                forCellWithReuseIdentifier: ProsConsCVC.classIdentifier
        )
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
        print("여기 실행\(prosConsTitleArray)")
        print("0값 확인\(zeroCheckArray)")
        for x in 0...3{
            if prosConsTitleArray[x] != ""{
                cvcCount += 1
            }
        }
    }
}

