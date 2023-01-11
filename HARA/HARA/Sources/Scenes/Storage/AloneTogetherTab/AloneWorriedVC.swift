//
//  WorriedAloneVC.swift
//  HARA
//
//  Created by 누리링 on 2023/01/06.
//

import UIKit
import SnapKit
import Then
import Moya


class AloneWorriedVC: UIViewController {

    // MARK: - Properties
    private let worriedAllButton = UIButton().then {
        $0.setImage(UIImage(named: "storage_ing_all"), for: .normal)
        $0.setImage(UIImage(named: "storage_complete_all"), for: .selected)
    }
    private let editButton = UIButton().then {
        $0.setTitle("편집", for: .normal)
        $0.setTitleColor(.hBlack, for: .normal)
        $0.titleLabel?.font = .haraB2M14
        $0.setTitle("완료", for: .selected)
    }
    
    private let clickButton = UIButton().then {
        $0.setImage(UIImage(named: "storage_check_off"), for: .normal)
    }
    
    private lazy var aloneCollectionView : UICollectionView  = {
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
    
    
    /// 셀 - 한 개 사이즈, 위치 지정
    final let aloneInset: UIEdgeInsets = UIEdgeInsets(top: 5, left: 12, bottom: 10, right: 12)
    
    ///여기부분 다시 보기 / section별, item별로 부여할 여백 상수로 저장
    final let aloneLineSpacing: CGFloat = 10
    final let aloneItemSpacing: CGFloat = 19
    
    var aloneList: [AloneWorriedModel] = [
        AloneWorriedModel(worring: "storage_ing", categoryTitle: "일상", mainText: "난 이제 지쳤어요 땡벌", date: "2022.12.25"),
        AloneWorriedModel(worring: "storage_ing", categoryTitle: "일상", mainText: "난 이제 지쳤어요 멍멍", date: "2022.12.25"),
        AloneWorriedModel(worring: "storage_ing", categoryTitle: "일상", mainText: "난 이제 지쳤어요 멍멍", date: "2022.12.25"),
        AloneWorriedModel(worring: "storage_ing", categoryTitle: "일상", mainText: "난 이제 지쳤어요 멍멍", date: "2022.12.25"),
        AloneWorriedModel(worring: "storage_ing", categoryTitle: "일상", mainText: "난 이제 지쳤어요 멍멍", date: "2022.12.25"),
        AloneWorriedModel(worring: "storage_ing", categoryTitle: "일상", mainText: "난 이제 지쳤어요 멍멍", date: "2022.12.25"),
        AloneWorriedModel(worring: "storage_ing", categoryTitle: "일상", mainText: "난 이제 지쳤어요 땡벌", date: "2022.12.25"),

    ]
    
    //var aloneDataSource: [DataModel] = DataModel.AloneSampleList

    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        registerCVC()
        setPress()
    }
    
    // MARK: - Function
    private func setPress() {
        worriedAllButton.press {
            self.worriedAllButton.isSelected.toggle()
        }
        editButton.press {
            self.editButton.isSelected.toggle()
                }

    }
}

extension AloneWorriedVC {
    /// 수직 스크롤이라는 가정 하에, rowCount는 몇개의 행을 사용할지를 저장한 변수

    private func registerCVC() {
        aloneCollectionView.register(
            AloneWorriedCVC.self, forCellWithReuseIdentifier: AloneWorriedCVC.identifier)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AloneWorriedVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let itemCellWidth = screenWidth - aloneInset.left - aloneInset.right - aloneItemSpacing
        return CGSize(width: itemCellWidth, height: 90)
    }
}

// MARK: - UICollectionViewDataSource
extension AloneWorriedVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return aloneList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let aloneCell = collectionView.dequeueReusableCell(withReuseIdentifier: AloneWorriedCVC.identifier, for: indexPath) as? AloneWorriedCVC else { return UICollectionViewCell() }
        aloneCell.dataBind(model: aloneList[indexPath.item])
        return aloneCell
    }
}

extension AloneWorriedVC {
    
    // MARK: - Layout
    private func setLayout() {
        view.addSubview(aloneCollectionView)
        [worriedAllButton, editButton].forEach {
            view.addSubview($0)
        }
        worriedAllButton.snp.makeConstraints{
            $0.top.equalToSuperview().inset(10.adjustedH)
            $0.leading.equalToSuperview().inset(7.adjustedW)
        }
        editButton.snp.makeConstraints{
            $0.top.equalToSuperview().inset(10.adjustedH)
            $0.trailing.equalToSuperview().inset(12)
        }
        view.backgroundColor = .clear
        aloneCollectionView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(40.adjustedH)
            $0.trailing.equalTo(2.adjustedW).inset(7)
            $0.leading.equalTo(2.adjustedW).inset(3)
//            $0.height.equalTo(calculateCellHeight())
            $0.bottom.equalToSuperview()
            
        }
    }
}
