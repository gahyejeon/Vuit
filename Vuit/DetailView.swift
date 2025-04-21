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
    var item: Item

    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            // 아이템 정보 박스
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 1.0, green: 0.957, blue: 0.639))
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
                    // 수정 기능
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
    }
}




