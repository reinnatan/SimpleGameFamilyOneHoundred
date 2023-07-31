//
//  ViewController.swift
//  familyonehoundred
//
//  Created by Reinhart on 29/07/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var questDesc: UILabel!
    @IBOutlet weak var survey1: UILabel!
    @IBOutlet weak var survey2: UILabel!
    @IBOutlet weak var survey3: UILabel!
    @IBOutlet weak var survey4: UILabel!
    @IBOutlet weak var survey5: UILabel!

    @IBOutlet weak var heightNextQuestion: NSLayoutConstraint!
    
    @IBOutlet weak var processQuestion: UIButton!
    
    @IBOutlet weak var btnAnswerQuestion: UIButton!
    @IBOutlet weak var btnNextQuestion: UIButton!
    @IBOutlet weak var userAnswer: UITextField!
    
    var question: [String:[String:Int]] =  [:]
    var index = 0
    var countFalseAnswer = 0
    var countCorrectAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnNextQuestion.isHidden = true
        self.initQuestion()
        
    }
    
    func fillAllSurvey(){
        let keys = [String] (question.keys)
        let selectedKey = keys[index]
        let answerKey = [String](self.question[selectedKey]!.keys)
        
        self.survey1.text = answerKey[0]
        self.survey2.text = answerKey[1]
        self.survey3.text = answerKey[2]
        self.survey4.text = answerKey[3]
        self.survey5.text = answerKey[4]
    }
    
    func resetSurvey(){
        self.survey1.text = ""
        self.survey2.text = ""
        self.survey3.text = ""
        self.survey4.text = ""
        self.survey5.text = ""
    }
    
    
    @IBAction func askSurvery(_ sender: Any) {
        self.mappingComponentQuestion()
        if(self.countFalseAnswer==6){
            self.countFalseAnswer = 0
            self.showDialogMessage(title: "Loose", message: "You are loose")
            self.fillAllSurvey()
            self.btnAnswerQuestion.isEnabled = false
            self.btnNextQuestion.isHidden = false
        }
        self.userAnswer.text = ""
    }
    
    @IBAction func nextQuestion(_ sender: Any) {
        self.btnNextQuestion.isHidden = true
        self.btnAnswerQuestion.isEnabled = true
        self.index = self.index + 1
        self.resetSurvey()
        self.fillNextQuestion()
        self.countFalseAnswer = 0
        self.countCorrectAnswer = 0
    }
    
    func initQuestion(){
        var answer1 = [String: Int]()
        answer1["mie"] = 5
        answer1["roti"] = 3
        answer1["bakpao"] = 2
        answer1["pastel abon"] = 6
        answer1["bakso"] = 40
        question["Makanan yang terbuat dari tepung"] = answer1
        
        var answer2 = [String:Int]()
        answer2["rumah sakit"] = 10
        answer2["puskesmas"] =  20
        answer2["mantri"] = 50
        answer2["dukun"] = 25
        answer2["tukang urut"] = 60
        question["Tempat berobat orang yang sedang sakit"] = answer2
        
        var answer3 = [String:Int]()
        answer3["ITB"] = 100
        answer3["UI"] = 50
        answer3["UGM"] = 50
        answer3["Unpad"] = 25
        answer3["Undip"] = 60
        question["Universitas terbaik diindonesia"] = answer3
        mappingComponentQuestion()
    }
    
    func mappingComponentQuestion(){
        if(index<3){
            let keys = [String] (question.keys)
            let selectedKey = keys[index]
            let answerKeys = [String](self.question[selectedKey]!.keys)
            
            self.questDesc.text = selectedKey
            var isSelect = false
            var correctAnswer = ""
            
            for answerKey in answerKeys{
                if answerKey.caseInsensitiveCompare(self.userAnswer.text ?? "") == .orderedSame{
                    isSelect = true
                    correctAnswer = answerKey
                    break
                }
            }
            
            if !isSelect  {
                showDialogMessage(title: "False answer", message: "Wrong Answer")
                self.countFalseAnswer = self.countFalseAnswer + 1
            }else {
                self.fillCorrectAnswer(correctAnswer: correctAnswer)
            }
           
            
        }
    }
    
    func fillCorrectAnswer(correctAnswer:String){
        let keys = [String] (question.keys)
        let selectedKey = keys[index]
        let answerKey = [String](self.question[selectedKey]!.keys)
        
        if answerKey[0] == correctAnswer{
            self.survey1.text = answerKey[0]
        }else if answerKey[1] == correctAnswer{
            self.survey2.text = answerKey[1]
        }else if answerKey[2] == correctAnswer{
            self.survey3.text = answerKey[2]
        }else if answerKey[3] == correctAnswer{
            self.survey4.text = answerKey[3]
        }else if answerKey[4] == correctAnswer{
            self.survey5.text = answerKey[4]
        }
        
        countCorrectAnswer = countCorrectAnswer + 1
        if countCorrectAnswer == 5 {
            showDialogMessage(title: "Selamat !!!", message: "Anda menang !!!")
            self.index =  self.index + 1
            mappingComponentQuestion()
            resetSurvey()
        }
        
    }
    
    func fillNextQuestion(){
        if(index<3){
            let keys = [String] (question.keys)
            let selectedKey = keys[index]
            let answerKey = [String](self.question[selectedKey]!.keys)
            self.questDesc.text = selectedKey
        }else{
            index = 0;
            let keys = [String] (question.keys)
            let selectedKey = keys[index]
            let answerKey = [String](self.question[selectedKey]!.keys)
            self.questDesc.text = selectedKey
        }
    }
    
    func showDialogMessage(title:String, message:String){
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             print("Ok button tapped")
          })
        
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
}

