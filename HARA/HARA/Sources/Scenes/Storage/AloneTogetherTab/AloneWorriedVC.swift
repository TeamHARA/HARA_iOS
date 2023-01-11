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
    
    ///여기부분 다시 보기 / section별, item별로 부여할 여백 상수로 저장
    final let aloneLineSpacing: CGFloat = 10
    
    var aloneList: [WorriedModel] = [
        WorriedModel(worring: "storage_ing", categoryTitle: "일상", mainText: "난 이제 지쳤어요 땡벌", date: "2022.12.25"),
        WorriedModel(worring: "storage_ing", categoryTitle: "일상", mainText: "난 이제 지쳤어요 멍멍", date: "2022.12.25"),
        WorriedModel(worring: "storage_ing", categoryTitle: "일상", mainText: "난 이제 지쳤어요 멍멍", date: "2022.12.25"),
        WorriedModel(worring: "storage_ing", categoryTitle: "일상", mainText: "난 이제 지쳤어요 멍멍", date: "2022.12.25"),
        WorriedModel(worring: "storage_ing", categoryTitle: "일상", mainText: "난 이제 지쳤어요 멍멍", date: "2022.12.25"),
        WorriedModel(worring: "storage_ing", categoryTitle: "일상", mainText: "난 이제 지쳤어요 멍멍", date: "2022.12.25"),
        WorriedModel(worring: "storage_ing", categoryTitle: "일상", mainText: "난 이제 지쳤어요 땡벌", date: "2022.12.25"),
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
            AloneWorriedCVC.self, forCellWithReuseIdentifier: AloneWorriedCVC.className)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AloneWorriedVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 343.adjustedW, height: 100.adjustedH)
    }
}

// MARK: - UICollectionViewDataSource
extension AloneWorriedVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return aloneList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let aloneCell = collectionView.dequeueReusableCell(withReuseIdentifier: AloneWorriedCVC.className, for: indexPath) as? AloneWorriedCVC else { return UICollectionViewCell() }
        aloneCell.dataBind(model: aloneList[indexPath.item])
        return aloneCell
    }
}

extension AloneWorriedVC {
    
    // MARK: - Layout
    private func setLayout() {
        view.backgroundColor = .clear
        view.addSubViews([aloneCollectionView, worriedAllButton, editButton])
        
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
        
        aloneCollectionView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(44.adjustedH)
            $0.leading.equalToSuperview().offset(16.adjustedW)
            $0.trailing.equalToSuperview().inset(16.adjustedW)
            $0.bottom.equalToSuperview()
        }
    }
}
