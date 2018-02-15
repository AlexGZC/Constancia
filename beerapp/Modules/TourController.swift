//
//  TourController.swift
//  beerapp
//
//  Created by elaniin on 1/19/18.
//  Copyright © 2018 Elaniin. All rights reserved.
//

import UIKit

class TourController: UIViewController {
    
    // MARK: - Let/Var/IBOutlet
    
    var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)
    
    let imagesList    = ["icon-slider-bottles", "icon-slider-raising-glasses", "icon-slider-bottles","icon-slider-bottles"]
    let texTitleList = ["Bares cerca de vos","Las Mejores Promociones","Gana Puntos","Gana Puntos"]
    let textDescriptionList = ["Encontrá los bares que andabas buscando y diviertete en cualquier partesdel país","Siempre queremos tengas lo mejor por eso te notificaremos siempre que tengamos una promoción especial para vos","Hace check en cada bar que visites y por cada registro obtén puntos, los cuales podes canjear en tu próxima visita","Gana Puntos"]
    var pageControlIsChangingPage = Bool()
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var sliderimageView: UIImageView!
    @IBOutlet weak var sliderLabel1: UILabel!
    @IBOutlet weak var sliderLabel2: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Scrollview is being delegated
        scrollView.delegate = self
        self.scrollView.isPagingEnabled = true
        
        //Calling our configuration about Pagecontrol
        self.configurePageControl()
        //General setUP
        setUp()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //data woring
    }
    
    // MARK: - Initializers/Setups
    
    func configurePageControl() {
        
        // The total number of pages that are available is based on how many available colors we have.
        self.pageControl.numberOfPages = 5
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = .white
        self.pageControl.pageIndicatorTintColor = .lightGray
        self.pageControl.currentPageIndicatorTintColor = .gray
       
        // pageControl constraints
        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.pageControl.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
       
        
    }

    func setUp(){
        
        //Animate
        Core.Fade(view: self.sliderLabel1)
        Core.Fade(view: self.sliderLabel2)
        Core.Fade(view: self.sliderimageView)
        Core.Fade(view: self.startButton)
        
        //Animate labels
        UIView.animate(withDuration: 1.0, delay: 0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 5, options: [], //options: nil
            animations: ({
                
                self.sliderLabel1.center.x = self.view.frame.width / 2
                
            }), completion: nil)
        
        self.scrollView.delegate = self
        //Delegate contentsize for Scrollview
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.size.width * 4,height: self.scrollView.frame.size.height)
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x,y :0), animated: true)
        
        self.pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
    }
    
    
    // TO CHANGE WHILE CLICKING ON PAGE CONTROL
    @objc func changePage(sender: AnyObject) -> () {
        
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
        
        
        
        
        switch pageControl.currentPage {
        case 0:
            
            Core.Fade2(view: self.sliderimageView)
            Core.Fade(view: self.sliderLabel1)
            Core.Fade(view: self.sliderLabel2)
            
            
            self.sliderimageView.image = UIImage(named: imagesList[0])!
            self.sliderLabel1.text = self.texTitleList[0].description
            self.sliderLabel2.text = self.textDescriptionList[0].description
        case 1:
            
            Core.Fade2(view: self.sliderimageView)
            Core.Fade(view: self.sliderLabel1)
            Core.Fade(view: self.sliderLabel2)
            
            
            self.sliderimageView.image = UIImage(named: imagesList[1])!
            self.sliderLabel1.text = self.texTitleList[1].description
            self.sliderLabel2.text = self.textDescriptionList[1].description
        case 2:
            
            Core.Fade2(view: self.sliderimageView)
            Core.Fade(view: self.sliderLabel1)
            Core.Fade(view: self.sliderLabel2)
            
            self.sliderimageView.image = UIImage(named: imagesList[2])!
            self.sliderLabel1.text = self.texTitleList[2].description
            self.sliderLabel2.text = self.textDescriptionList[2].description
        case 3:
            
            Core.Fade2(view: self.sliderimageView)
            Core.Fade(view: self.sliderLabel1)
            Core.Fade(view: self.sliderLabel2)
            
            
            self.sliderimageView.image = UIImage(named: imagesList[3])!
            self.sliderLabel1.text = self.texTitleList[3].description
            self.sliderLabel2.text = self.textDescriptionList[3].description
            
            
        default:
            
            break
            
        }
    }
}

extension TourController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.pageControlIsChangingPage == false{
            var pageWidth: CGFloat = scrollView.frame.size.width
            var page: Int = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
            pageControl.currentPage = page
            print(pageControl.currentPage)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        
        // Test the offset and calculate the current page after scrolling ends
        
        self.pageControlIsChangingPage = false
        
        
        
        
    }
    
}

