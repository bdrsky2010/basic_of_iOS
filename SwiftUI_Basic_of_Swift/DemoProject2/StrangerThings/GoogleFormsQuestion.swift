//
//  GoogleFormsQuestion.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/9/23.
//

import Foundation

struct Question {
	let question: String
	let score: Int?
}

let questions: [Question] = [
	Question(question: "이번 주 수업 난이도는 어떠셨나요?", score: nil),
	Question(question: "진행되는 수업 진행 속도는 어떻게 생각하시나요?  [박준영 강사님]", score: nil),
	Question(question: "실습으로 배정된 교육 시간이 충분하셨나요?  [박준영 강사님]", score: nil),
	Question(question: "제공된 학습 자료는 만족하시나요? [박준영 강사님]", score: nil),
	Question(question: "이번 주 진행된 강의에 만족하시나요? [유민영 강사님", score: nil),
	Question(question: "수업 중 질의응답에서 충분한 도움을 받았나요?", score: nil),
	Question(question: "8주차에 진행 된 깃/깃헙 특강에서 충분한 도움을 받았나요?", score: nil),
	Question(question: "진행된 특강에 대한 의견을 자유롭게 작성해주세요. 좋았던 점/ 아쉬웠던 점/ 특강강사님께 하시고 싶은 말씀 등등 자유롭게 작성해주세요! ", score: nil),
	Question(question: "금주 행정 서비스(문의사항 응대, 출결 정정 등)에 만족하시나요?", score: nil),
	Question(question: "운영적으로 개선하고 싶거나, 요청사항이 있는 경우 자유롭게 작성해주세요.", score: nil),
	Question(question: "이번 주 수업에서 좋았던 점을 자유롭게 작성해 주세요. 도움이 되었던 것(수업진행 방식, 실습비중, 특강 등)", score: nil),
	Question(question: "이번 주 수업에서 아쉬웠던 점을 자유롭게 작성해 주세요. 수강 중 아쉬운 점, 건의사항 등", score: nil),
	Question(question: "칭찬하고 싶은 동료가 있다면 알려주세요!! ", score: nil),
	Question(question: "커뮤니티 규율 위반 사례가 있었다면 알려주세요!", score: nil),
]
