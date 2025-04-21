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
                // 아이템 정보 박스
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.postColor)
                    .frame(height: 300)
                    .overlay(
                        Text("Created at \(item.timestamp.formatted(date: .abbreviated, time: .shortened))")
                            .foregroundStyle(.black)
                            .padding()
                    )
                
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




