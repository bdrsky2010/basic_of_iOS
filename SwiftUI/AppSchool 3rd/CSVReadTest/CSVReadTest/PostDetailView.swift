//
//  PostDetailView.swift
//  FinalHrmiProjects
//
//  Created by Minjae Kim on 1/26/24.
//

import SwiftUI

struct PostDetailView: View {
	
	@Binding var isLike: Bool
	@Binding var likeCount: Int
	
	private let nickname = "hrmi"
	private let images = ["foodEx1", "foodEx2", "foodEx3", "foodEx4"]
	@State private var imageIndex = 0
	
	private let drinks = ["카누카 칵테일 700ml", "글렌알라키 10년 캐스크 스트래쓰 700ml", "카누카 칵테일 700ml"]
	private let starRating = [4.5, 4.0, 5.0]
	
	private let tags = ["대방어", "새우튀김", "광어", "우럭", "이거 한 줄에 몇개 넣어야 할까?", "정렬 문제도", "뭘까", "짬뽕", "짜장", "탕수육", "팔보채", "치킨", "피자", "족발"]
	
	@State private var currentPage = 0
	
	@State private var windowWidth: CGFloat = 0
	
	var body: some View {
		VStack {
			ScrollView {
				HStack {
					// 사용자의 프로필 사진
					Image("appIcon")
						.resizable()
						.frame(width: 30, height: 30)
						.clipShape(.circle)
					
					VStack(alignment: .leading) {
						// 사용자의 닉네임
						Text(nickname)
							.lineLimit(1)
							.font(.regular18)
							.foregroundStyle(.mainBlack)
						// 게시글 올린 날짜
						Text("2023.12.08")
							.font(.regular14)
							.foregroundStyle(.gray01)
					}
					
					Spacer()
					
					// 좋아요 버튼
					HStack(spacing: 3) {
						// 좋아요를 등록 -> 빨간색이 채워진 하트
						// 좋아요를 해제 -> 테두리가 회색인 하트
						Image(systemName: isLike ? "heart.fill" : "heart")
							.foregroundStyle(isLike ? .mainAccent01 : .gray01)
						Text("\(likeCount)")
							.foregroundStyle(.gray01)
					}
					.font(.regular16)
					.padding(.trailing, 10)
					.onTapGesture {
						likeButtonAction()
					}
				}
				.padding(.horizontal, 20)
				
				TabView {
					ForEach(0..<images.count, id: \.self) { index in
						Image(images[index])
							.resizable()
							.aspectRatio(contentMode: .fill)
							.clipped()
					}
				}
				.frame(height: 350)
				.padding(.bottom, 10)
				.tabViewStyle(.page)
				
				VStack(spacing: 20) {
					HStack {
						Text("\(nickname)의 술평가")
							.font(.bold16)
						Spacer()
					}
					ForEach(0..<drinks.count, id:\.self) { index in
						HStack(spacing: 2) {
							Text(drinks[index])
								.font(.semibold16)
								.lineLimit(1)
							Spacer()
							
							let rating = starRating[index]
							let fullStars = Int(rating)
							let hasHalfStar = (rating - Double(fullStars)) >= 0.5
							HStack(spacing: 5) {
								HStack(spacing: 0) {
									ForEach(0..<5) { index in
										Image(systemName: index < fullStars ? "star.fill" : (hasHalfStar && index == fullStars ? "star.leadinghalf.filled" : "star"))
											.foregroundStyle(.mainAccent03)
									}
								}
								Text(String(format: "%.1F", starRating[index]))
									.font(.semibold14)
								Image(systemName: "chevron.forward")
							}
						}
						.padding(.horizontal, 10)
					}
					Divider()
						.background(.gray01)
					
					Text("""
방어는 다양한 방법으로 맛있게 조리할 수 있습니다. 다음은 몇 가지 방어를 맛있게 먹는 방법들입니다:

1. 구이나 튀김: 방어는 오븐이나 프라이팬에서 구워서 먹을 수 있습니다. 신선한 방어에 소금, 후추, 올리브 오일, 식초, 다양한 허브를 더해주면 풍부한 맛을 즐길 수 있습니다. 
2. 조림: 방어를 간장, 설탕, 다진 마늘, 생강과 함께 끓여서 조림으로 만들 수 있습니다. 이 방법은 방어의 부드러운 풍미를 강조해줍니다. 
3. 회: 신선한 방어를 얇게 썬 후 레몬 주스나 간장 소스와 함께 먹는 것도 맛있습니다. 신선한 재료로 만들어진 회는 풍부한 맛과 신선한 식감을 제공합니다. 
4. 구운 방어 김밥: 구운 방어를 김밥 속에 넣어 간단한 반찬 또는 간식으로 먹을 수 있습니다. 신선한 야채와 함께 감칠맛을 더할 수 있습니다.

양식과 한식, 다양한 조리법을 통해 방어를 다양하게 즐길 수 있으니 자신의 취향에 맞게 시도해보세요!
""")
						.font(.regular16)
					
					VStack(alignment: .leading, spacing: 10) {
						ForEach(TagHandler.getRows(tags: tags,
												   spacing: 15,
												   fontSize: 14,
												   windowWidth: windowWidth,
												   tagString: "# "), id: \.self) { row in
							HStack(spacing: 15) {
								ForEach(row, id: \.self) { tag in
									Text("# \(tag)")
										.font(.semibold14)
										.foregroundStyle(.mainAccent04)
								}
							}
						}
					}
					.frame(width: windowWidth, alignment: .leading)
				}
				.padding(.horizontal, 20)
			}
		}
		.task {
			windowWidth = TagHandler.getScreenWidth(padding: 20)
		}
	}
	
	// 좋아요 버튼 액션 메서드
	private func likeButtonAction() {
		// 좋아요 등록 -> 좋아요 수에 + 1
		// 좋아요 해제 -> 좋아요 수에 - 1
		if isLike {
			likeCount -= 1
		} else {
			likeCount += 1
		}
		isLike.toggle()
	}
}

#Preview {
	PostDetailView(isLike: .constant(false), likeCount: .constant(45))
}

