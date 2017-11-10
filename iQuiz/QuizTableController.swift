//
//  ViewController.swift
//  iQuiz
//
//  Created by Nestor Qin on 11/5/17.
//  Copyright © 2017 Nestor Qin. All rights reserved.
//

import UIKit

class QuizTableController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // outlets
    @IBOutlet weak var table: UITableView!
    // properities
    var quizsImages: [UIImage] = [UIImage(named: "img1")!, UIImage(named: "img2")!, UIImage(named: "img3")!]
    var quizsTitle: [String] = ["Mathematics", "Marvel Super Heroes", "Science!"];
    var descriptions: [String] = ["Did you pass the third grade?", "Avengers, Assemble!", "Because SCIENCE!"];
    var quizs: [(title: String, description: String, image: UIImage)] = [(title: String, description: String, image: UIImage)]()
    var scienceQuestions: [(text: String, answer: Int, answers: [String])] =
        [(text: "What is fire?", answer: 1, answers: ["One of the four classical elements","A magical reaction given to us by God","A band that hasn't yet been discovered","Fire! Fire! Fire! heh-heh"])]
    var marvelQuestions: [(text: String, answer: Int, answers: [String])] =
        [(text: "Who is Iron Man?", answer: 1, answers: ["Tony Stark","Obadiah Stane","A rock hit by Megadeth","Nobody knows"]), (text: "Who founded the X-Men?", answer: 2, answers: ["Tony Stark","Professor X","The X-Institute","Erik Lensherr"]), (text: "How did Spider-Man get his powers?", answer: 1, answers: ["He was bitten by a radioactive spider","He ate a radioactive spider","He is a radioactive spider","He looked at a radioactive spider"])]
    var mathQuestions: [(text: String, answer: Int, answers: [String])] =
        [(text: "What is 2+2?", answer: 1, answers: ["4","22","An irrational number","Nobody knows"])]
    var questions = [[(text: String, answer: Int, answers: [String])]]()
    fileprivate var questionVC: QuestionViewController?
    
    fileprivate func questionBuilder() {
        if questionVC == nil {
            questionVC =
                storyboard?
                    .instantiateViewController(withIdentifier: "questionVC")
                as? QuestionViewController
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.dataSource = self
        self.table.delegate = self
        if (quizsImages.count != quizsTitle.count ||
            quizsImages.count != descriptions.count) {
            fatalError("Wrong Quiz Element Numbers")
        }
        for index in 0...(quizsImages.count - 1) {
            quizs.append((title: quizsTitle[index], description: descriptions[index], image: quizsImages[index]))
        }
        questions.append(mathQuestions)
        questions.append(marvelQuestions)
        questions.append(scienceQuestions)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.quizs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "theQuizCell", for: indexPath) as? QuizCell else {
            fatalError("The dequeued cell is not an instance of QuizCell.")
        }
        cell.title?.text = quizs[indexPath.row].title
        cell.descrip?.text = quizs[indexPath.row].description
        cell.photoImage?.image = quizs[indexPath.row].image
        return cell //4.
    }
    
    @IBAction func onSettingsClick(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // do view switch when the user choose one cell
        questionBuilder()
        questionVC?.questions = self.questions[indexPath.row]
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        present(questionVC!, animated: false, completion: nil)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "segueToMaster" && segue.destination is MasterViewController
//        {
//            let vc = segue.destination as? MasterViewController
//
//        }
//    }
//
//    private func loadSampleQuizs() {
//        let image1 = UIImage(named: "img1")
//        let image2 = UIImage(named: "img2")
//        let image3 = UIImage(named: "img3")
//        guard let quiz1 = QuizCell(quizTitle: quizsName[0], quizDescription: descriptions[0], image: image1!) else {
//            fatalError("Unable to instantiate meal1")
//        }
//        guard let quiz2 = QuizCell(quizTitle: quizsName[1], quizDescription: descriptions[1], image: image2!) else {
//            fatalError("Unable to instantiate meal1")
//        }
//        guard let quiz3 = QuizCell(quizTitle: quizsName[2], quizDescription: descriptions[2], image: image3!) else {
//            fatalError("Unable to instantiate meal1")
//        }
//        quizs += [quiz1, quiz2, quiz3]
//    }
}

