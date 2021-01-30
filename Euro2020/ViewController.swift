//
//  ViewController.swift
//  Euro2020
//
//  Created by Stéphane Trouvé on 30/01/2021.
//

import UIKit

class ViewController: UIViewController {

    lazy var view0: UIView = {
        let view = UIView()
        view.backgroundColor = .systemTeal
        let label = UILabel()
        label.text = "Page 1"
        label.textAlignment = .center
        view.addSubview(label)
        label.edgeTo(view: view)
        
        return view
        
    }()

    lazy var view1: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        let label = UILabel()
        label.text = "Page 2"
        label.textAlignment = .center
        view.addSubview(label)
        label.edgeTo(view: view)
        
        return view
        
    }()
    
    lazy var view2: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        let label = UILabel()
        label.text = "Page 3"
        label.textAlignment = .center
        view.addSubview(label)
        label.edgeTo(view: view)
        
        return view
        
    }()
    
    lazy var views = [view0, view1, view2]
    
    lazy var scrollview: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.isPagingEnabled = true
        scrollview.contentSize = CGSize(width: view.frame.width * CGFloat(views.count), height: view.frame.height)
        for i in 0..<views.count {
            scrollview.addSubview(views[i])
            views[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
        }
        return scrollview
        
    }()
    
    lazy var pageControl: UIPageControl = {
       let pageControl = UIPageControl()
        pageControl.numberOfPages = views.count
        pageControl.addTarget(self, action: #selector(pageControlTapHandler(sender:)), for: .touchUpInside)
        return pageControl
    
    }()
    
    @objc
    func pageControlTapHandler(sender: UIPageControl) {
        scrollview.scrollTo(horizontalPage: sender.currentPage, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(scrollview)
        scrollview.edgeTo(view: view)
        
        view.addSubview(pageControl)
        scrollview.pinTo(view)
        
    }


}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}
