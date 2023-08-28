# Pindergarten(핀더가든)
<img src="https://user-images.githubusercontent.com/68727819/167339490-f177d89c-7058-4e2f-b24a-bb15ca8f78a1.png" width="200"/>

반려견이 혼자있는 시간을 해결하기 위한 __반려견 유치원 정보 제공__ 및 __커뮤니티 서비스__ 입니다. 
<br><br>
__위치를 기반으로__ 반려견 유치원들을 소개해주고 상세 정보와 리뷰 등을 볼 수 있는 서비스입니다. 
<br><br>
커뮤니티에서 나의 반려견을 자랑할 수 있고 내 반려견들을 관리할 수 있습니다.

<br>

## 개발환경 및 주요 라이브러리
![Badge](https://img.shields.io/badge/swift-5.0-orange.svg?)
![Badge](https://img.shields.io/badge/Xcode-12.5-blue.svg?)
![Badge](https://img.shields.io/badge/Snapkit-5.0.1-yellowgreen.svg?)
![Badge](https://img.shields.io/badge/Alamofire-5.4.3-orange.svg?)
![Badge](https://img.shields.io/badge/Kingfisher-6.3.0-yellow.svg?)

<br>

## 주요 기능 실행 영상
### 커뮤니티 기능

![홈탭](https://user-images.githubusercontent.com/68727819/167310409-aacee8c1-6c37-46a6-998f-9b73a1c3460b.gif)
![게시물상세](https://user-images.githubusercontent.com/68727819/167310761-80644af3-dde2-40b1-a76a-9aa2ea9b6023.gif)
![게시물등록](https://user-images.githubusercontent.com/68727819/167310771-61f8d96a-40e9-444b-9fca-f0353400162a.gif)

<br>

### 위치 기반 유치원 조회

![핀더가든탭](https://user-images.githubusercontent.com/68727819/167310821-c72c759b-800f-4ba4-9ab2-94415f80df93.gif)
![유치원상세](https://user-images.githubusercontent.com/68727819/167310825-62feb878-7e95-4bfd-8f37-5c62c7c0f80c.gif)
![검색](https://user-images.githubusercontent.com/68727819/167310835-824cb2f7-ff65-4601-b737-d02c4deec59d.gif)
![위치환경설정](https://user-images.githubusercontent.com/68727819/167310903-e0c4ebcc-da66-410a-aaf8-b493c2f53dec.gif)

<br>

<details>
<summary>이외 화면들</summary>
<div markdown="1">

<img src="https://user-images.githubusercontent.com/68727819/167311112-b96acca0-df5e-4746-999d-6366cfdc7b68.PNG" width="200"/>
<img src="https://user-images.githubusercontent.com/68727819/167311566-3a0d5ff1-6058-4353-9682-8d0984d1bf62.PNG" width="200"/>
<img src="https://user-images.githubusercontent.com/68727819/167311571-17f3cd33-d2f1-481f-b739-a4e158066f0d.PNG" width="200"/> 
<img src="https://user-images.githubusercontent.com/68727819/167311574-5fada227-e083-45e4-9ba8-fb338420585f.PNG" width="200"/>
<img src="https://user-images.githubusercontent.com/68727819/167311576-ac2c712f-632e-4ee3-b178-40f783332821.PNG" width="200"/>
<img src="https://user-images.githubusercontent.com/68727819/167340326-7ee051db-46e1-495b-8d3a-fed05dd16e19.PNG" width="200"/>
<img src="https://user-images.githubusercontent.com/68727819/167311264-57399cf1-56fa-4930-973f-1d6049258971.PNG" width="200"/>
<img src="https://user-images.githubusercontent.com/68727819/167311305-9fe21963-08f9-420f-b3ec-2e18a0d0a230.PNG" width="200"/>
<img src="https://user-images.githubusercontent.com/68727819/167311303-764458dd-0558-4c3c-8b27-f9350b230ed2.PNG" width="200"/>
<img src="https://user-images.githubusercontent.com/68727819/167311310-73226e0a-f363-4195-968a-236031440c4d.PNG" width="200"/>
<img src="https://user-images.githubusercontent.com/68727819/167311376-49a1da61-b244-4421-9da1-fe2a7890dae2.PNG" width="200"/>
<img src="https://user-images.githubusercontent.com/68727819/167311314-4a579fb3-3a8a-4fd1-ad62-686b0613c138.PNG" width="200"/>

</div>
</details>

<br><br>
## Trouble Shooting

### 이미지 down sampling을 통한 메모리 최적화와 caching, pagination을 통한 scroll 시 효율적인 이미지 로드

- 커뮤니티 기능에서 게시물의 사진들이 많아지면서 이미지 로딩이 느려지는 이슈

- WWDC 영상([Image and Graphics Best Practices](https://developer.apple.com/videos/play/wwdc2018/219/?time=877))을 통해  iOS에서 이미지가 화면에 보여지는 과정에 대해 이해도를 높이고 해당 과정에 필요한 라이브러리(**Kingfisher**)를 선택해 Kingfisher의 기능들과 메서드들을 알아보고 이미지 down sampling과 caching을 적용

- UIScrollViewDelegate의 scrollViewDidScroll(_ scrollView: UIScrollView) 함수를 활용해 화면의 특정 위치에서 새로운 데이터를 불러오며 pagination 적용

### CollectionViewFlowLayout을 subclassing한 Custom Layout을 통해 고정된 width와 유동적인 height를 가지는 cell을 일정한 간격으로 띄운 UI 구현

- UIKit의 collectionview에 기본적으로 사용되는 UICollectionViewFlowLayout은 특정 라인에 따라서 가장 큰 Cell 을 기준으로 다른 Cell 이 중앙 정렬을 하게 되는 것이 원인으로 홈 피드에서 서로 다른 크기의 cell이 위로 정렬이 되지 않고 가운데 정렬이 되는 이슈

- UIKit에서 기본적으로 제공해주는 UICollectionViewFlowLayout의 구현을 코드 레벨에서 확인하고 메서드와 프로퍼티를 override하여 Custom Layout을 구성
