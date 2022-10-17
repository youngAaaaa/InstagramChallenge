# InstagramChallenge
> '인스타그램'APP 클론  
> 프로젝트 기간 : 22.07.25 ~ 22.08.07   
## 상세설명
### - 스플래시
| 자동로그인 ⭕️ | 자동로그인 ❌, JWT 토큰 만료 |
| ---- | --- |
| <img width="280" src="https://user-images.githubusercontent.com/97266875/196167077-69bccad8-b1d9-41dc-a419-2079fbd9f646.gif"> | <img width="280" src="https://user-images.githubusercontent.com/97266875/196169144-e129f691-638a-4bc5-ba65-ef2210ead12c.gif">

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
| <img width="280" src="https://user-images.githubusercontent.com/97266875/196178067-b54eec28-b9dc-4092-b008-33c92fdea959.gif"> | <img width="280" src="https://user-images.githubusercontent.com/97266875/196178597-e6897426-091c-4a65-9f25-bb3710fbff22.gif"> | <img width="280" src="https://user-images.githubusercontent.com/97266875/196179436-268946a2-b1a7-4084-97a0-ddc1cb259be0.gif"> |

| 비밀번호 만들기 | 생일 추가 | 약관 동의 |
| ---- | --- | --- |
| <img width="280" src="https://user-images.githubusercontent.com/97266875/196181421-d274a26f-fcd4-435a-9eb4-b7939ebad49a.gif"> | <img width="280" src="https://user-images.githubusercontent.com/97266875/196181447-245d7402-d003-40c2-b46a-9503ac5b3f80.gif"> | <img width="280" src="https://user-images.githubusercontent.com/97266875/196181455-3b0b9657-78e6-41b8-9bd4-4a6e927a5523.gif"> |

| 사용자 이름 만들기 | 최종 확인 |
| ---- | --- |
| <img width="280" src="https://user-images.githubusercontent.com/97266875/196182802-d38678fe-c2ac-4e33-922a-0a580e84a801.gif"> | <img width="280" src="https://user-images.githubusercontent.com/97266875/196182809-4d0f6df0-8853-4488-8579-8725ff6ab1f3.gif"> |
