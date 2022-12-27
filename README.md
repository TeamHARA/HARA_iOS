# HARA
> 고민 관련 서비스 .... 서비스 설명

# 🛠 프로젝트 세팅
- 미니멈 타겟: 미정
- 대응 기기: iPhone 13 mini

# 👨‍👧‍👧 Contributors

사진 및 깃헙 아이디 추가 예정

## 🤔 역할 분담
### 김담인
### 배성호
### 조누리

# 👁‍🗨 Library

|                     라이브러리                      |                   용도                    |
| :-------------------------------------------------: | :---------------------------------------: |




# 🖥 Code Convention

추가 예정
# 🌀 Git Flow
추가 예정
 
## 작업 순서
```
1. Issue 생성
2. Branch 생성
3. 작업, commit
4. push
5. PR 작성
6. 코드 리뷰 (24시간 이내)
7. 두 명(권장), 한 명(최소) Approve 받았을 경우 셀프 merge
8. Delete Branch
```
## Commit Convention
`타입: 설명 #이슈 번호`

```
  Feat: 새로운 주요 기능 추가
  Add: 파일 추가, 에셋 추가
  Fix: 버그 수정
  Del: 쓸모없는 코드 삭제
  Refactor: 코드 리팩토링
  Mod: 스토리보드, Xib 파일 수정
  Move: 프로젝트 구조 변경
  Rename: 파일, 클래스, 변수명 등 이름 변경
  Docs: Wiki, README 파일 수정
  Chore: 그 외
```
## Branch

- 가장 처음에 붙는 분류 영역에서는, 커밋 컨벤션의 워딩과 동일하게 작성합니다.

### Branch Naming

> `분류` /`#이슈 번호` - `작업할 뷰` - `상세 작업 내역`
> 

```swift
chore/#3-Project-Setting
feat/#3-HomeView-UI
fix/
refactor/#1-

```

## Merge

- 본인의 `PR`은 본인이 `Merge`합니다.
- 최대한 빨리, 최대 24시간 이내에 코드 리뷰를 등록합니다.
- 최신화를 자주 하자!
- Approve를 최소 1명한테 받아야 Merge가 가능합니다.
    - 2명이 최대한 Approve 줄 수 있도록 합시다!
- 코드 리뷰를 하면서 필수적인 수정 사항을 발견할 경우, `Approve` 대신 `Request Changes`를 주어 수정을 요구합니다.
    - 해당 `PR` 작업자는, 수정 사항을 반영하여 새로 `commit`을 추가한 후, 해당 `PR`에 `push`하여 `Re-request review`를 요청합니다.
        1. `Request Changes`: 컨벤션 
        2. `Approve`: 일단 OK! 로직, 리팩토링 가능한 부분, 더 나은 코드를 위한 제안 등
- 모든 작업이 완료되어 `Merge`가 된 경우, 해당 `PR` 하단의 `Delete Branch`를 선택하여 작업이 끝난 `Branch`를 삭제합니다.
 
# 📁 Foldering Convention

추가 예정