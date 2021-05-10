//
//  ViewController.swift
//  nom-nom
//
//  Created by Michelle Gao on 4/29/21.
//

import UIKit

protocol GroceryDelegate: class {
}

class ViewController: UIViewController, GroceryDelegate {
    
    private var featureCollectionView: UICollectionView!
    
    private var titleLabel : UILabel = UILabel()
    private var messageLabel: UILabel = UILabel()
    
    private let featureCellReuseIdentifier = "featureCellReuseIdentifier"
    private let featureCellPadding: CGFloat = 30
    
    private var features = [
        Feature(image: UIImage(named: "grocerybag")!, title: "Grocery List", description: "Buy sum fooooooood"),
        Feature(image: UIImage(named: "recipe_browser")!, title: "Recipe Browser", description: "What's new in the kitchen?"),
        Feature(image: UIImage(named: "chef")!, title: "Favorite Recipes", description: "The good ones."),
        Feature(image: UIImage(named: "calendar")!, title: "Weekly Meals", description: "What's on the menu?")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Nom Nom"
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        setUpViews()
        setUpConstraints()
    }
    
    func setUpViews() {
        titleLabel.text = "Hello Nom-mer!"
        titleLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 30)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        messageLabel.text = "You're allowed to eat today."
        messageLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 12)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageLabel)
        
        let featureLayout = UICollectionViewFlowLayout()
        featureLayout.scrollDirection = .vertical
        featureLayout.minimumInteritemSpacing = featureCellPadding
        featureLayout.minimumLineSpacing = featureCellPadding
        
        featureCollectionView = UICollectionView(frame: .zero, collectionViewLayout: featureLayout)
        featureCollectionView.backgroundColor = .clear
        featureCollectionView.showsVerticalScrollIndicator = false
        featureCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(featureCollectionView)
        
        featureCollectionView.register(FeatureCollectionViewCell.self, forCellWithReuseIdentifier: featureCellReuseIdentifier)
        featureCollectionView.dataSource = self
        featureCollectionView.delegate = self
        
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            messageLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])
        NSLayoutConstraint.activate([
            featureCollectionView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 50),
            featureCollectionView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            featureCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            featureCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }


}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return features.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let featureCell = featureCollectionView.dequeueReusableCell(withReuseIdentifier: featureCellReuseIdentifier, for: indexPath) as! FeatureCollectionViewCell
        let featureObject = features[indexPath.item]
        featureCell.configure(for: featureObject)
        return featureCell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if features[indexPath.item].title == "Grocery List" {
            let groceryViewController = GroceryViewController()
            navigationController?.pushViewController(groceryViewController, animated: true)
        }
        else if features[indexPath.item].title == "Recipe Browser" {
            let browserViewController = BrowserViewController()
            navigationController?.pushViewController(browserViewController, animated: true)
        }
        else if features[indexPath.item].title == "Weekly Meals" {
            let mealPlannerViewController = MealPlannerViewController()
            navigationController?.pushViewController(mealPlannerViewController, animated: true)
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 320, height: 100)
    }
    
}
