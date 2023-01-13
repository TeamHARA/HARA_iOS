//
//  FourthStepView.swift
//  HARA
//
//  Created by saint on 2023/01/03.
//

import UIKit
import SnapKit
import Then

// MARK: - Protocols
protocol CheckVc4Delegate: AnyObject{
    func checkCategory(checkTextfield: Bool)
}

protocol ServerVc4Delegate: AnyObject{
    func saveVc4Data(categoryId: Int)
}

class FourthWriteStepVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
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
    
    private let questionLabel = UILabel().then{
        $0.numberOfLines = 2
        let normalString1 = NSAttributedString(string: "고민의 ", attributes: [
            .font: UIFont.haraM1M24])
        let boldString = NSAttributedString(string: "카테고리", attributes: [
            .font: UIFont.haraM1B24])
        let normalString2 = NSAttributedString(string: "를\n정해주세요.", attributes: [
            .font: UIFont.haraM1M24])
        
        let title = normalString1 + boldString + normalString2
        $0.attributedText = title
    }
    
    private let categoryTextField = UITextField().then{
        $0.tintColor = .clear
        $0.backgroundColor = .clear
//        $0.layer.borderWidth = 1
//        $0.layer.borderColor = UIColor.hBlue3.cgColor
//        $0.layer.cornerRadius = 8
        $0.borderStyle = .none
        $0.placeholder = "카테고리를 선택해주세요"
        $0.textColor = .hGray3
        $0.font = .haraH2M16
    }
    
    private let categoryTextLine = UILabel().then{
        $0.backgroundColor = .hBlue3
    }
    
    private let pickerImage = UIImageView().then {
        $0.image = UIImage(named: "categoryBtn")
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .clear
    }
    
    private var checkTextfield: Bool = false
    
    /// category 결정해주는 pickerView
    private let pickerView = UIPickerView().then{
        $0.backgroundColor = .hWhite
    }
    private let categories = ["일상", "연애", "패션/뷰티", "커리어", "운동", "여행", "기타"]
    var selectedItem = "일상"
    
    private var categoryId: Int = 0
    
    weak var checkVc4Delegate: CheckVc4Delegate?
    weak var serverVc4Delegate: ServerVc4Delegate?
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .hGray4
        setLayout()
        pickerView.delegate = self
        pickerView.dataSource = self
        setLayout()
        configPickerViewToolbar()
    }
    
    // MARK: - Functions
    func configPickerViewToolbar() {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        let btnSelect = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(onPickDone))
        let spaceLeft = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let categoryLabel = UILabel().then{
            $0.text = "카테고리"
            $0.font = .haraM2M18
            $0.textColor = .hBlack
        }
        let barTitle = UIBarButtonItem(customView: categoryLabel)
        let spaceRight = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btnCancel = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(onPickCancel))
        toolBar.setItems([btnCancel, spaceLeft, barTitle, spaceRight, btnSelect], animated: true)
        toolBar.isUserInteractionEnabled = true
        categoryTextField.inputView = pickerView
        categoryTextField.inputAccessoryView = toolBar
    }
    
    /// 피커뷰 > 확인 클릭
    @objc func onPickDone() {
        categoryTextField.text = selectedItem
        categoryTextField.textAlignment = .center
        categoryTextField.textColor = .black
        categoryTextField.resignFirstResponder()
        //selectedItem = ""
        /// 피커뷰에서 item을 select 했을 시에만 다음 페이지로 가는 버튼이 활성화 됨
        checkTextfield = true
        checkVc4Delegate?.checkCategory(checkTextfield: checkTextfield)
        
        for x in 0..<categories.count{
            if categories[x] == selectedItem{
                categoryId = x + 1
            }
        }
        serverVc4Delegate?.saveVc4Data(categoryId: categoryId)
    }
    
    /// 피커뷰 > 취소 클릭
    @objc func onPickCancel() {
        categoryTextField.resignFirstResponder() // 피커뷰를 내림 (텍스트필드가 responder 상태를 읽음)
        selectedItem = ""
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTextField.text = categories[row]
        categoryTextField.textAlignment = .center
        categoryTextField.textColor = .black
        selectedItem = categories[row]
    }
}

extension FourthWriteStepVC{
    private func setLayout(){
        view.addSubViews([background, navigationView, progressView, questionLabel,
                         categoryTextField, categoryTextLine, pickerImage])
        
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
        
        pickerImage.snp.makeConstraints{
            $0.bottom.equalTo(categoryTextLine.snp.top).offset(-10.adjustedH)
            $0.trailing.equalToSuperview().offset(-16.adjustedW)
            $0.width.equalTo(24.adjustedW)
            $0.height.equalTo(24.adjustedH)
        }
        
        categoryTextField.snp.makeConstraints{
            $0.top.equalTo(questionLabel.snp.bottom).offset(157.adjustedH)
            $0.centerY.equalTo(pickerImage)
            $0.leading.equalTo(16.adjustedW)
            $0.trailing.equalTo(-16.adjustedW)
            $0.height.equalTo(40.adjustedH)
        }
        
        categoryTextLine.snp.makeConstraints{
            $0.bottom.leading.trailing.equalTo(categoryTextField)
            $0.height.equalTo(1.adjustedH)
        }
    }
}
