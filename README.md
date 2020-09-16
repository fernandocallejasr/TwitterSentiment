# Twitter Sentiment
Use the power of machine learning to know in an instant what people think about any topic, account, or hashtag in Twitter.
![Image](/images/screenshot1.png)
![Image2](/images/screenshot2.png)
![Image3](/images/screenshot3.png)
# Features
*  We use a machine learning Natural Language Processing (NLP) model to predict if a tweet sentiment was Neutral, Positive or Negative.
* We fetch the last 100 tweets about your search and obtain an overall score of them. A positive tweet sums a point, a negative tweet is minus one point and neutral points don't sum.
* After obtaining the overall score the user gets the result as an emoji that shows the sentiment over that topic, account, or hashtag.
# How to Get Sarted
1. Install the latest version of Xcode from the Mac AppStore.
2. Install  [CocoaPods](https://cocoapods.org/)  to your machine.
3. Fork the project and clone it to your local machine.
4. In the terminal, change directory to the one that contains the project.
5. Run  `pod install`  to be able to build locally.
6. Login as a Twitter Developer and use yoour keys in ViewController.swift to be able to fetch the tweets.
