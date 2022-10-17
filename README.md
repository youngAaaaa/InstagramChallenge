# InstagramChallenge
> '인스타그램'APP 클론  
> 프로젝트 기간 : 22.07.25 ~ 22.08.07(2주간)   
## 상세설명

<h3> 📌 사용한 라이브러리 </h3>

```
  pod 'Alamofire'
  
  pod 'Kingfisher', '~> 7.3.0'
  
  pod 'XLPagerTabStrip', '~> 9.0'
  
  pod 'KakaoSDKCommon'  # 필수 요소를 담은 공통 모듈
  pod 'KakaoSDKAuth'  # 사용자 인증
  pod 'KakaoSDKUser'  # 카카오 로그인, 사용자 관리
  
  pod 'FirebaseStorage'
  pod 'FloatingPanel'
```

### - 스플래시
| 자동로그인 ⭕️ | 자동로그인 ❌, JWT 토큰 만료 |
| ---- | --- |
| <img width="250" src="https://user-images.githubusercontent.com/97266875/196167077-69bccad8-b1d9-41dc-a419-2079fbd9f646.gif"> | <img width="250" src="https://user-images.githubusercontent.com/97266875/196169144-e129f691-638a-4bc5-ba65-ef2210ead12c.gif">

<br>

### - 로그인
https://user-images.githubusercontent.com/97266875/196171884-e4c22dbc-acbc-45b6-81b1-c539389b8bc0.mp4
- 화면 설명
  - 아이디 입력
    - 자유 형식으로 20자 이상 입력 불가
    - 엔터 대신 비밀번호 입력으로 커서 이동 존재
  - 비밀번호 입력
    - 자유 형식으로 20자 이상 입력 불가
    - 엔터 대신 로그인 버튼을 대체 클릭하는 버튼 존재
  - 로그인 버튼
    - 아무것도 입력되어 있지 않으면 비활성화 상태이며 클릭 불가(옅은 파란색)
    - 아이디/비밀번호 입력란에 1글자 이상 입력된 경우 활성화 상태로 변경되며 클릭 가능 (진한 파란색)
    - 클릭 시 유효성 검사 실시(아이디/비밀번호 3자 이상 20자 이하 & 비밀번호에 특수문자 1자리 이상 포함)
      - 성공 시 서버에서 존재하는 유저인지 확인
      - 실패 시 실패 팝업 노출
  - 비밀번호 보이기/가리기
    - 입력된 비밀번호의 기본 값은 보이지 않는 상태
    - 눈 아이콘 클릭 시 아이콘의 이미지가 변경되며 비밀번호 보여짐
    - 다시 눈 아이콘 클릭 시 아이콘의 이미지가 변경되며 비밀번호 가려짐
  - 가입하기
    - 가입하기 클릭 시 회원가입으로 이동
### - 소셜 로그인
https://user-images.githubusercontent.com/97266875/196176873-13e04c09-af86-47a4-9262-d8e6fdce6668.mp4

<br>

### - 회원가입
| 휴대폰 입력 | 인증번호 입력 | 이름 추가 |
| ---- | --- | --- |
| <img width="250" src="https://user-images.githubusercontent.com/97266875/196178067-b54eec28-b9dc-4092-b008-33c92fdea959.gif"> | <img width="250" src="https://user-images.githubusercontent.com/97266875/196178597-e6897426-091c-4a65-9f25-bb3710fbff22.gif"> | <img width="250" src="https://user-images.githubusercontent.com/97266875/196179436-268946a2-b1a7-4084-97a0-ddc1cb259be0.gif"> |

| 비밀번호 만들기 | 생일 추가 | 약관 동의 |
| ---- | --- | --- |
| <img width="250" src="https://user-images.githubusercontent.com/97266875/196181421-d274a26f-fcd4-435a-9eb4-b7939ebad49a.gif"> | <img width="250" src="https://user-images.githubusercontent.com/97266875/196181447-245d7402-d003-40c2-b46a-9503ac5b3f80.gif"> | <img width="250" src="https://user-images.githubusercontent.com/97266875/196181455-3b0b9657-78e6-41b8-9bd4-4a6e927a5523.gif"> |

| 사용자 이름 만들기 | 최종 확인 |
| ---- | --- |
| <img width="250" src="https://user-images.githubusercontent.com/97266875/196182802-d38678fe-c2ac-4e33-922a-0a580e84a801.gif"> | <img width="250" src="https://user-images.githubusercontent.com/97266875/196182809-4d0f6df0-8853-4488-8579-8725ff6ab1f3.gif"> |

<br>

## CRUD 기능
### - 피드 작성
https://user-images.githubusercontent.com/97266875/196184578-b1ca8a1b-e999-438c-937f-b4caa3cd9669.mp4
- 사진 선택
  - 초기 값은 가장 첫번째 사진
  - 사진 선택 시, 선택된 사진은 뿌옇게 마스킹 처리
  - 다른 사진 선택 시, 기존 사진은 마스킹 처리가 사라지며 새롭게 선택된 사진이 마스킹 처리됨
- 글 작성
  - 클릭 시 글작성 모드로 변경
    - 작성중인 부분 이외의 부분은 검정색으로 블러 처리
    - 상단 타이틀 '문구'로 변경
    - 상단 우측 버튼 '확인'으로 변경
- 공유 버튼
  - 사진 저장은 'Firebase'로 진행
  
<br>

### - 피드 불러오기
https://user-images.githubusercontent.com/97266875/196190895-90ec35c7-c050-43fa-a6b1-f74cc3edc590.mp4
- 피드 목록
  - 페이징을 통해 목록 구현
  - 한 페이지마다 10개의 피드 구성
  - 무한 스크롤 가능
  - 가장 상단의 피드를 보고 있는 상황에서 드래그 시 피드 목록 새로고침 진행
- 사진 슬라이드
  - 사진의 장수는 인디케이터로 확인 가능
- 더보기
  - 내가 작성한 글인 경우에만 클릭 가능
  - 클릭 시 바텀 시트 노출
  
<br>

### - 피드 수정
https://user-images.githubusercontent.com/97266875/196193167-d9c2e2bd-729e-4131-a8e4-e787de8b16f1.mp4

<br>

### - 피드 삭제
https://user-images.githubusercontent.com/97266875/196193805-50276d46-ad65-44f8-b999-f50228d888ec.mp4
