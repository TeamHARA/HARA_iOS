//
//  OneSecGameVC.swift
//  HARA
//
//  Created by saint on 2023/01/11.
//

import UIKit
import SnapKit
import Then

class OneSecGameVC: UIViewController {
    // MARK: - Properties
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
        $0.text = "1초만에 고민 해결"
        $0.font = .haraH1Sb16
    }
    
    private let placeHolder: String = "고민의 제목을 입력해주세요."
    
    private let worryTextfield = UITextField().then {
        $0.font = .haraB3R14
        $0.borderStyle = .roundedRect
        $0.layer.borderColor = UIColor.hBlue3.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .clear
        $0.textColor = .hBlack
        $0.textAlignment = .center
    }
    
    private let answerBaseImage = UIImageView().then {
        $0.image = UIImage(named: "answerBackground")
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .clear
    }
    
    private let answerLabel = UILabel().then {
        $0.numberOfLines = 4
        $0.font = .haraM2M18
        $0.textAlignment = .center
        //$0.text = "안녕\n잘가\n안녕\n잘가"
    }
    
    private let pickButton = UIButton().then {
        $0.backgroundColor = .hWhite
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.hOrange3.cgColor
        $0.titleLabel?.font = .haraH1Sb16
        $0.setTitle("해결 카드 뽑기", for: .normal)
        $0.setTitleColor(.hGray2, for: .normal)
        $0.isUserInteractionEnabled = false
    }
    
    private var buttonstate: Bool = true
    
    private let recentTitle = UILabel().then {
        $0.font = .haraH1Sb16
        $0.text = "지난 나의 고민"
    }
    
    private let recentIntro = UILabel().then {
        $0.font = .haraSub3R12
        $0.textColor = .hGray2
        $0.text = "최근 10개의 고민까지만 저장되고 오래된 순으로 자동 삭제돼요!"
    }
    
    private let flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
    }
    
    lazy var recentWorryCV = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then{
        $0.backgroundColor = .clear
        $0.delegate = self
        $0.dataSource = self
        $0.showsVerticalScrollIndicator = false
    }
    
    var worryList: [RecentWorryModel] = [
        RecentWorryModel(date: "22.12.15", worryTitle: "어떤 공부부터 시작할까요?"),
        RecentWorryModel(date: "22.12.15", worryTitle: "어떤 공부부터 시작할까요?"),
        RecentWorryModel(date: "22.12.15", worryTitle: "어떤 공부부터 시작할까요?"),
        RecentWorryModel(date: "22.12.15", worryTitle: "어떤 공부부터 시작할까요?"),
        RecentWorryModel(date: "22.12.15", worryTitle: "어떤 공부부터 시작할까요?"),
        RecentWorryModel(date: "22.12.15", worryTitle: "어떤 공부부터 시작할까요?"),
        RecentWorryModel(date: "22.12.15", worryTitle: "어떤 공부부터 시작할까요?"),
        RecentWorryModel(date: "22.12.15", worryTitle: "어떤 공부부터 시작할까요?"),
        RecentWorryModel(date: "22.12.15", worryTitle: "어떤 공부부터 시작할까요?"),
        RecentWorryModel(date: "22.12.15", worryTitle: "어떤 공부부터 시작할까요?")
    ]
    
    var answerList: [String] = [
        "전화번호부\n3번째에 있는\n사람에게\n연락해봐요!",
        "시간이\n약이에요",
        "ESTJ가\n답을 알고\n있어요",
        "초성이 ㅅㅎ인\n사람에게\n물어보세요",
        "지금 바로\n실행하세요!",
        "마음을\n비우세요",
        "한 타임\n쉬어가세요",
        "처음\n생각한 게\n맞아요",
        "도전해\n보세요!",
        "돈을\n아낄 때도\n필요해요",
        "한번 더\n생각해보세요",
        "꼭 오늘일\n필요는 없어요"
    ]
    
    final let listLineSpacing: CGFloat = 10.adjustedH
    final let listInset: UIEdgeInsets = UIEdgeInsets(top: 16.adjustedH, left: 16.adjustedH, bottom: 0, right: 16.adjustedH)
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setLayout()
        setPress()
        registerCV()
        setupTextField()
    }
    
    // MARK: - Function
    private func setPress() {
        closeButton.press {
            if self.navigationController == nil{
                self.dismiss(animated: true, completion: nil)
            }
            self.navigationController?.dismiss(animated: true)
        }
        pickButton.press { [self] in
            if buttonstate == true{
                answerBaseImage.image = UIImage(named: "answerResultBackground")
                answerLabel.text = answerList.randomElement()
                pickButton.setTitle("다시 뽑기", for: .normal)
                buttonstate = false
            }
            else if buttonstate == false{
                worryTextfield.text = placeHolder
                worryTextfield.textColor = .hGray3
                answerBaseImage.image = UIImage(named: "answerBackground")
                answerLabel.text = ""
                pickButton.setTitle("해결 카드 뽑기", for: .normal)
                buttonstate = true
                /// 1.  뽑기 버튼 비활성화
                pickButton.isUserInteractionEnabled = false
                /// 2.  버튼 디자인 변경
                pickButton.setTitleColor(.hGray2, for: .normal)
                pickButton.backgroundColor = .hWhite
                pickButton.layer.borderColor = UIColor.hOrange3.cgColor
            }
        }
    }

    private func registerCV() {
        recentWorryCV.register(RecentWorryCVC.self,
                                forCellWithReuseIdentifier: RecentWorryCVC.classIdentifier
        )
    }
    
    func setupTextField() {
        worryTextfield.delegate = self
        worryTextfield.text = placeHolder /// 초반 placeholder 생성
        worryTextfield.textColor = .hGray3 /// 초반 placeholder 색상 설정
    }
}

// MARK: - Layout
extension OneSecGameVC{
    private func setLayout(){
        view.backgroundColor = .hWhite
        self.view.insertSubview(background, at: 0)
        view.addSubViews([closeButton, titleLabel, worryTextfield, answerBaseImage, pickButton, recentTitle, recentIntro, recentWorryCV])
        answerBaseImage.addSubview(answerLabel)
        
        background.snp.makeConstraints{
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalTo(pickButton.snp.bottom).offset(16.adjustedH)
        }
        
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
        
        worryTextfield.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(32.adjustedH)
            $0.leading.equalToSuperview().offset(16.adjustedW)
            $0.trailing.equalToSuperview().offset(-16.adjustedW)
            $0.height.equalTo(40.adjustedH)
        }
        
        answerBaseImage.snp.makeConstraints{
            $0.top.equalTo(worryTextfield.snp.bottom).offset(16.adjustedH)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(175.adjustedW)
            $0.height.equalTo(214.adjustedH)
        }
        
        answerLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(49.adjustedH)
            $0.centerX.equalToSuperview()
        }
        
        pickButton.snp.makeConstraints{
            $0.top.equalTo(answerBaseImage.snp.bottom).offset(14.adjustedH)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(153.adjustedW)
            $0.height.equalTo(40.adjustedH)
        }
        
        recentTitle.snp.makeConstraints{
            $0.top.equalTo(background.snp.bottom).offset(16.adjustedH)
            $0.leading.equalToSuperview().offset(16.adjustedW)
        }
        
        recentIntro.snp.makeConstraints{
            $0.top.equalTo(recentTitle.snp.bottom).offset(8.adjustedH)
            $0.leading.equalTo(recentTitle)
        }
        
        recentWorryCV.snp.makeConstraints{
            $0.top.equalTo(recentIntro.snp.bottom).offset(10.adjustedH)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITextFieldDelegate
extension OneSecGameVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textField.textColor = .hBlack
            textField.text = placeHolder
        } else if textField.text! == placeHolder {
            textField.textColor = .hBlack
            textField.text = nil
        }
    }
    
    internal func textFieldDidEndEditing(_ textField: UITextField) {
        /// 플레이스홀더
        if textField.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || textField.text! == placeHolder {
            textField.text = placeHolder
            textField.textColor = .hGray3
            /// 1.  뽑기 버튼 비활성화
            pickButton.isUserInteractionEnabled = false
            /// 2.  버튼 디자인 변경
            pickButton.setTitleColor(.hGray2, for: .normal)
            pickButton.backgroundColor = .hWhite
            pickButton.layer.borderColor = UIColor.hOrange3.cgColor
        }
        else{
            textField.textColor = .hBlack
            /// 1.  뽑기 버튼 활성화
            pickButton.isUserInteractionEnabled = true
            /// 2.  버튼 디자인 변경
            pickButton.setTitleColor(.white, for: .normal)
            pickButton.backgroundColor = .hOrange1
            pickButton.layer.borderColor = UIColor.hOrange1.cgColor
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OneSecGameVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 343.adjustedW, height: 64.adjustedH)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return listLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return listInset
    }
}

// MARK: - UICollectionViewDataSource
extension OneSecGameVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return worryList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let worryCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecentWorryCVC.classIdentifier, for: indexPath)
                as? RecentWorryCVC else { return UICollectionViewCell() }
        worryCell.dataBind(model: worryList[indexPath.item])
        return worryCell
    }
}
