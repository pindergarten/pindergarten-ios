//
//  OnboardingViewController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/27.
//

import UIKit

class OnboardingPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
            return nil
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        
        pageControl.currentPage = currentIndex
    }
   
    //MARK: - Properties
    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    let initialPage = 0
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUp()
        style()
        layout()
        
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Action
    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }
    
    //MARK: - Helpers
    func setUp() {
        dataSource = self
        delegate = self
        
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)

//        let page1 = OnboardingController(titleName: "다양한 반려견들과의 소통", script: "게시물과 하트, 댓글로 다양한\n반려견들과의 소통을 해보세요!\n귀여움과 재미가 동시에!", imageName: "onboarding-1")
//        let page2 = OnboardingController(titleName: "내 주변 펫 유치원", script: "나와 가까운 펫 유치원을 찾고,\n그에 맞는 상세정보까지 한번에!", imageName: "onboarding-2")
//        let page3 = OnboardingController(titleName: "소중한 반려견 등록", script: "나의 소중한 반려견들을 등록하고,\n내가 올린 게시물을 한 눈에 기록해보세요!", imageName: "onboarding-3", last: true)
//
        let page1 = OnboardingController(titleImage: "11", imageName: "onboarding-1")
        let page2 = OnboardingController(titleImage: "12", imageName: "onboarding-2")
        let page3 = OnboardingController(titleImage: "13", imageName: "onboarding-3", last: true)
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
    
    func style() {
        pageControl.currentPageIndicatorTintColor = .mainBrown
        pageControl.pageIndicatorTintColor = UIColor(hex: 0xC4C4C4)
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
    }
    
    func layout() {
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            make.width.equalTo(view)
            make.height.equalTo(20)
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
    }
}
