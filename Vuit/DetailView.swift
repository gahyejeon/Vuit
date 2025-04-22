//
//  DetailView.swift
//  Vuit
//
//  Created by 내꺼다 on 4/15/25.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var isNavigationToPostingView = false
    
    var item: Item
    
    var body: some View {
        ZStack {
            Color.backColor.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                
                // 텍스트보이는 곳 스크롤 가능하게 하기 위해 스크롤뷰로 수정
                ZStack(alignment: .topLeading) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.postColor)
                            .frame(minHeight: 300, maxHeight: 400)

                        ScrollView {
                            Text(item.text)
                                .foregroundStyle(.black)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(minHeight: 300, maxHeight: 400)
                    }
                
                // 버튼 두 개를 HStack으로 붙이기
                HStack(spacing: 5) {
                    Spacer()
                    
                    Button("수정하기") {
                        // 작성화면 연결
                        isNavigationToPostingView = true
                    }
                    .padding()
                    .background(Color.clear)
                    .foregroundStyle(.gray)
                    
                    Button("삭제하기") {
                        modelContext.delete(item)
                        dismiss()
                    }
                    .padding()
                    .background(Color.clear)
                    .foregroundStyle(.gray)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("부잇 - 상세글보기")
            .navigationDestination(isPresented: $isNavigationToPostingView) {
                PostingView()
            }
        }
    }
    
}


// 삭제 얼럿 창 만들기



