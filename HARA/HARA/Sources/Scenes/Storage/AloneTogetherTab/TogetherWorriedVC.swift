//
//  worriedTogetherVC.swift
//  HARA
//
//  Created by 누리링 on 2023/01/06.
//

import UIKit
import SnapKit
import Then
import Moya
import SwiftUI

class TogetherWorriedVC: UIViewController {

    // MARK: - Properties
    private let worriedAllButton = UIButton().then {
        $0.setImage(UIImage(named: "storage_ing_all"), for: .normal)
    }
    private let editButton = UIButton().then {
        $0.setTitle("편집", for: .normal)
        $0.setTitleColor(.hBlack, for: .normal)
        $0.titleLabel?.font = .haraB2M14
        $0.setTitle("완료", for: .selected)
    }
    
    var isWorring: Bool?
    
    private let clickButton = UIButton().then {
        $0.setImage(UIImage(named: "storage_check_off"), for: .normal)
    }
    
    private lazy var togetherCollectionView : UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isEditing = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsFocusDuringEditing = true
        collectionView.allowsMultipleSelection = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset.bottom = 60
        return collectionView
    }()
    
    ///여기부분 다시 보기 / section별, item별로 부여할 여백 상수로 저장
    final let togetherLineSpacing: CGFloat = 10
    var togetherData: [StorageResponse] = []

    let categoryList: Array<String> = ["전체", "일상", "연애", "패션/뷰티", "커리어", "운동", "여행", "기타"]
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        registerCVC()
        setPress()
        isWorring = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isWorring == true {
            self.getWithWorry(ifSolved: 0)
        } else {
            self.getWithWorry(ifSolved: 1)
        }
    }
    
    // MARK: - Functions
    private func setPress() {
        worriedAllButton.press {
            self.isWorring?.toggle()
            if self.isWorring == true {
                self.worriedAllButton.setImage(UIImage(named: "storage_ing_all"), for: .normal)
                self.getWithWorry(ifSolved: 0)

            }else{
                self.worriedAllButton.setImage(UIImage(named: "storage_complete_all"), for: .normal)
                self.getWithWorry(ifSolved: 1)
            }
        }
        editButton.press {
            self.editButton.isSelected.toggle()
        }
    }
    
    private func registerCVC() {
        togetherCollectionView.register(
            TogetherWorriedCVC.self, forCellWithReuseIdentifier: TogetherWorriedCVC.className)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension TogetherWorriedVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 343.adjustedW, height: 100.adjustedH)
    }
}

// MARK: - UICollectionViewDataSource
extension TogetherWorriedVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return togetherData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let togetherCell = collectionView.dequeueReusableCell(withReuseIdentifier: TogetherWorriedCVC.className, for: indexPath) as? TogetherWorriedCVC else { return UICollectionViewCell() }
        togetherCell.dataBind(model: togetherData[indexPath.row])
        ///indexPath.row
        return togetherCell
    }
}

extension TogetherWorriedVC {
    
    // MARK: - Layout
    private func setLayout() {
        view.backgroundColor = .clear
        view.addSubViews([togetherCollectionView, worriedAllButton, editButton])
        
        worriedAllButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10.adjustedH)
            $0.leading.equalToSuperview().offset(16.adjustedW)
            $0.width.equalTo(77.adjustedW)
            $0.height.equalTo(24.adjustedH)
        }
        
        editButton.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16.adjustedW)
            $0.width.equalTo(27.adjustedW)
            $0.height.equalTo(44.adjustedH)
        }
        
        togetherCollectionView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(44.adjustedH)
            $0.leading.equalToSuperview().offset(16.adjustedW)
            $0.trailing.equalToSuperview().inset(16.adjustedW)
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - Network
extension TogetherWorriedVC {
    func getWithWorry(ifSolved: Int){
        StorageAPI.shared.getStorageWithList(param11: ifSolved) { [weak self] result in
            guard let res = result else { return }
            let count = (res.data?.count)!
            guard let dataModel = res.data else {return}
            self?.togetherData = dataModel
            self?.togetherCollectionView.reloadData()
            print("배열의 길이입니다\(count)")
        }
    }
    
}
