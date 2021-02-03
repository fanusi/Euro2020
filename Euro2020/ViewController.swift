//
//  ViewController.swift
//  Euro2020
//
//  Created by Stéphane Trouvé on 30/01/2021.
//

import UIKit

class ViewController: UIViewController {
    
    var PronosA = [Pronostiek]()
    // PronosA contains real scores
    
    var PronosB = [[Pronostiek]]()
    // PronosB contains guesses of all players
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    lazy var view0: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
//        let label = UILabel()
//        label.text = "Page 1"
//        label.textAlignment = .center
//        view.addSubview(label)
//        label.edgeTo(view: view)
        
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
        scrollview.delegate = self
        
        return scrollview
        
    }()
    
    lazy var pageControl: UIPageControl = {
       let pageControl = UIPageControl()
        pageControl.numberOfPages = views.count
        pageControl.currentPage = 0
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
    
        fixtureParsing()
        
        self.temp()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            
            self.scoreView()
            
        }

        
            
    }
    
    func temp () {
        
        view.addSubview(scrollview)
        scrollview.edgeTo(view: view)

        view.addSubview(pageControl)
        pageControl.pinTo(view)
        
    }
    

    func scoreView () {
        
        testpronos()
        routine()
        createlabels()
        
    }
    
    
    func createlabels() {
        
        let t:Int = 20
        // Create t+1 test pronos
        
        let g:Int = 20
        // Number of games
        
        let br = view0.bounds.width
        let ho = view0.bounds.height
        
        let label1 = UILabel(frame: CGRect(x: br * 0.05, y: ho * 0.10 + ho * 0.05, width: br * 0.40, height: ho * 0.05))
        
        let label2 = UILabel(frame: CGRect(x: br * 0.50, y: ho * 0.10 + ho * 0.05, width: br * 0.20, height: ho * 0.05))
        
        label1.textAlignment = NSTextAlignment.left
        label1.text = "Player"
        label1.font.withSize(12)
        //label.backgroundColor = .red
        label1.textColor = .black
        view0.addSubview(label1)
                            
        label2.textAlignment = NSTextAlignment.center
        label2.text = "Points"
        label2.font.withSize(12)
        //label.backgroundColor = .red
        label2.textColor = .black
        view0.addSubview(label2)
        
        
        for i in 0...t {
            
            let label1 = UILabel(frame: CGRect(x: br * 0.05, y: ho * 0.20 + ho * 0.05 * CGFloat(i), width: br * 0.40, height: ho * 0.05))
            
            let label2 = UILabel(frame: CGRect(x: br * 0.50, y: ho * 0.20 + ho * 0.05 * CGFloat(i), width: br * 0.20, height: ho * 0.05))
            
            //Test 2
            
            label1.textAlignment = NSTextAlignment.left
            label1.text = PronosB[i][0].user
            label1.font.withSize(12)
            //label.backgroundColor = .red
            label1.textColor = .black
            view0.addSubview(label1)
                                
            label2.textAlignment = NSTextAlignment.center
            label2.text = String(puntenSommatie(z: g, speler: PronosB[i]))
            label2.font.withSize(12)
            //label.backgroundColor = .red
            label2.textColor = .black
            view0.addSubview(label2)
            
        }
        
    }
    
    func puntenSommatie (z: Int, speler: [Pronostiek]) -> Int {
        
        var som:Int = 0
        
        for l in 0...z {
            
            som = som + Int(speler[l].statistiek?.punten ?? 0)
            
        }
        
        return som
        
    }
    
    func calculator (speler: [Pronostiek]) {
        
        let g:Int = 20
        // Number of games
        
        var punten:Int = 0
        
        for j in 0...g {
            
            //reset punten voor elke match
            punten = 0
            
            if PronosA[j].home_Goals > PronosA[j].away_Goals && speler[j].home_Goals > speler[j].away_Goals {
                
                punten = punten + 1
                
                if PronosA[j].home_Goals == speler[j].home_Goals {
                    
                    punten = punten + 1
                    
                }
                
                if PronosA[j].away_Goals == speler[j].away_Goals {
                    
                    punten = punten + 1
                    
                }
                
            }

            if PronosA[j].home_Goals < PronosA[j].away_Goals && speler[j].home_Goals < speler[j].away_Goals {
                
                punten = punten + 1
                
                if PronosA[j].home_Goals == speler[j].home_Goals {
                    
                    punten = punten + 1
                    
                }
                
                if PronosA[j].away_Goals == speler[j].away_Goals {
                    
                    punten = punten + 1
                    
                }
                     
            }

            if PronosA[j].home_Goals == PronosA[j].away_Goals && speler[j].home_Goals == speler[j].away_Goals {
                
                punten = punten + 1
                
                if PronosA[j].home_Goals == speler[j].home_Goals {
                    
                    punten = punten + 2
                    
                }
                     
            }
            
            //toewijzen van punten
            let stat = Statistiek(context: context)
            stat.punten = Int16(punten)
            stat.user = speler[j].user
            
            speler[j].statistiek = stat
            
        }
        
    }
    
    func routine () {
        
        let t:Int = 20
        // Create t+1 test pronos
        
        for i in 0...t {
            
            calculator(speler: PronosB[i])
            
        }
        
    }
    
    func testpronos () {
        
        //Populate PronosB with random data
        
        let t:Int = 20
        // Create t+1 test pronos
    
        let g:Int = 20
        // Number of games
        
        for i in 0...t {
            
            // Loop players
            
            let newArrayFixtures = [Pronostiek(context: self.context)]
            PronosB.append(newArrayFixtures)
            
            PronosB[i][0].user = "User " + String(i+1)
            PronosB[i][0].fixture_ID = PronosA[0].fixture_ID
            PronosB[i][0].round = PronosA[0].round
            PronosB[i][0].home_Goals = Int16.random(in: 0..<4)
            PronosB[i][0].away_Goals = Int16.random(in: 0..<4)
            PronosB[i][0].home_Team = PronosA[0].home_Team
            PronosB[i][0].away_Team = PronosA[0].away_Team
            
            for n in 1...g {
                
                // Loop games

                let newFixture = Pronostiek(context: self.context)
                newFixture.user = "User " + String(i+1)
                newFixture.fixture_ID = PronosA[n].fixture_ID
                newFixture.round = PronosA[n].round
                newFixture.home_Goals = Int16.random(in: 0..<4)
                newFixture.away_Goals = Int16.random(in: 0..<4)
                newFixture.home_Team = PronosA[n].home_Team
                newFixture.away_Team = PronosA[n].away_Team
                PronosB[i].append(newFixture)
                
            }
            
        }

//        for n in 0...g {
//
//            for i in 0...t  {
//
//                print(n)
//                print(i)
//                print(PronosB[i][n].user ?? "Error 1")
//                print(PronosB[i][n].fixture_ID)
//                print(PronosB[i][n].home_Team)
//                print(PronosB[i][n].away_Team)
//                print(PronosB[i][n].home_Goals ?? "Error 1")
//                print(PronosB[i][n].away_Goals ?? "Error 1")
//                print("Next")
//
//            }
//
//        }
        
    }
    
    func fixtureParsing () {
            
            //Populate PronosA from FootballAPI
        
            let headers = [
                "x-rapidapi-key": "a08ffc63acmshbed8df93dae1449p15e553jsnb3532d9d0c9b",
                "x-rapidapi-host": "api-football-v1.p.rapidapi.com"
            ]

            let request = NSMutableURLRequest(url: NSURL(string: "https://api-football-v1.p.rapidapi.com/v2/fixtures/league/403?timezone=Europe%2FLondon")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers

            let session = URLSession.shared
        
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                
                
            if error == nil && data != nil {
                
                    
            let decoder = JSONDecoder()
                    
            do {
                        
                
                    let g = 297
                    let niveau1 = try decoder.decode(api1.self, from: data!)
                    print(niveau1)
                    
                    for n in 0...g {

                        //print(niveau1.api.fixtures[n].fixture_id)
                        let newFixture = Pronostiek(context: self.context)
                        newFixture.fixture_ID = Int32(niveau1.api.fixtures[n].fixture_id)
                        newFixture.round = niveau1.api.fixtures[n].round
                        newFixture.home_Goals = Int16(niveau1.api.fixtures[n].goalsHomeTeam)
                        newFixture.away_Goals = Int16(niveau1.api.fixtures[n].goalsAwayTeam)
                        newFixture.home_Team = niveau1.api.fixtures[n].homeTeam.team_name
                        newFixture.away_Team = niveau1.api.fixtures[n].awayTeam.team_name
                        
                        
                        self.PronosA.append(newFixture)
                        //try self.context.savePronos2()

                    }
                
                        
                } catch {
                    
                    debugPrint(error)
                }
                    
            }
                            
            })
                
            dataTask.resume()

    }


}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollview.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
