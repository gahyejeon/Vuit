//
//  PostingView.swift
//  Vuit
//
//  Created by 내꺼다 on 4/15/25.
//

import SwiftUI

struct PostingView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var editingItem: Item? // 수정할 아이템
    
    @State private var postText: String = ""
    
    var body: some View {
        ZStack {
            Color.backColor.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                ZStack(alignment: .topLeading) {
                    // 배경 박스
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.postColor)
                        .frame(height: 300)
                    
                    // 텍스트 에디터
                    TextEditor(text: $postText)
                        .scrollContentBackground(.hidden)
                        .padding()
                        .foregroundColor(.black)
                        .frame(height: 300)
                    
                    // placeholder
                    if postText.isEmpty {
                        Text("이곳에 작성해 주세요!")
                            .foregroundColor(.gray)
                            .padding(.top, 25)
                            .padding(.leading, 24)
                    }
                }
                
                // 저장 버튼 (여기로할지 네비게이션바 오른쪽으로 할지..)
                HStack {
                    Spacer()
                    Button(editingItem == nil ? "작성하기" : "수정완료") {
                        if let editingItem = editingItem {
                            editingItem.text = postText
                        } else {
                            let newItem = Item(timestamp: Date(), text: postText)
                            modelContext.insert(newItem)
                        }
//                        let newItem = Item(text: postText)
//                        modelContext.insert(newItem)
                        dismiss()
                    }
                    .padding()
                    .background(Color.clear)
                    .foregroundStyle(postText.isEmpty ? Color.gray.opacity(0.3) : Color.black)
                    .disabled(postText.isEmpty)
                }

                Spacer()
            }
            .padding()
            .navigationTitle(editingItem == nil ? "글 작성하기" : "글 수정하기")
            .onAppear {
                if let editingItem = editingItem {
                    postText = editingItem.text
                }
            }
        }
    }
}

#Preview {
    PostingView()
}
