//
//  ViewController.swift
//  TwitterSentiment
//
//  Created by user177767 on 9/8/20.
//  Copyright © 2020 Fernando Callejas. All rights reserved.
//

import UIKit
import SwifteriOS
import SwiftyJSON
import CoreML

class ViewController: UIViewController {
    
    @IBOutlet weak var sentimentLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var analysisButton: UIButton!
    
    let tweetCount = 100
    
    let sentimentClassifier = TweetSentimentClassifier()
    
    let swifter = Swifter(consumerKey: "your Twitter API key", consumerSecret: "your Twitter API secret key")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        textField.delegate = self
        
        analysisButton.layer.cornerRadius = 22.0
    }
    
    @IBAction func predictPressed(_ sender: UIButton) {
        fetchTweets()
    }
    
    func fetchTweets() {
        
        if let searchText = textField.text {
            
            swifter.searchTweet(using: searchText, lang: "en", count: tweetCount, tweetMode: .extended, success: { (results, metadata) in
                
                var tweets = [TweetSentimentClassifierInput]()
                
                for i in 0..<self.tweetCount {
                    
                    if let tweet = results[i]["full_text"].string {
                        let tweetForClassification = TweetSentimentClassifierInput(text: tweet)
                        tweets.append(tweetForClassification)
                    }
                }
                
                self.makePrediction(with: tweets)
                
            }) { (error) in
                print("Error with the Twitter API Request: \(error)")
            }
        }
        
    }
    
    func makePrediction(with tweets: [TweetSentimentClassifierInput]) {
        
        do {
            
            let predictions = try self.sentimentClassifier.predictions(inputs: tweets)
            
            var sentimentScore = 0
            
            for inference in predictions {
                
                switch inference.label {
                case "Pos":
                    sentimentScore += 1
                case "Neg":
                    sentimentScore -= 1
                default:
                    sentimentScore += 0
                }
                
            }
            
            updataUI(with: sentimentScore)
            
            
        } catch {
            print("Error making classifications: \(error)")
        }
        
    }
    
    func updataUI(with sentimentScore: Int) {
        
        switch sentimentScore {
        case 20...:
            self.sentimentLabel.text = "😍"
        case 10...19:
            self.sentimentLabel.text = "😄"
        case 1...9:
            self.sentimentLabel.text = "🙂"
        case 0:
            self.sentimentLabel.text = "😐"
        case (-10)...(-1):
            self.sentimentLabel.text = "😕"
        case (-20)...(-11):
            self.sentimentLabel.text = "😡"
        case ...(-21):
            self.sentimentLabel.text = "🤮"
        default:
            self.sentimentLabel.text = "😴"
        }
        
    }
    
}

//MARK: - Text Field Delegate Methods

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            textField.endEditing(true)
            return true
        } else {
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        fetchTweets()
        
        resignFirstResponder()
    }
    
}
