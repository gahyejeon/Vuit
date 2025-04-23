//
//  DetailView.swift
//  Vuit
//
//  Created by 내꺼다 on 4/15/25.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Query var allComments: [Comment]
    
    @State private var isNavigationToPostingView = false
    @State private var deleteAlert = false
    
    @State private var newCommentText = ""
    @State private var editingComment: Comment?
    
    var item: Item
    
    var commentsForItem: [Comment] {
        allComments.filter { $0.item?.id == item.id}.sorted { $0.createdAt > $1.createdAt }
    }
    
    var body: some View {
        ZStack {
            Color.backColor.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                
                // 텍스트보이는 곳 스크롤 가능하게 하기 위해 스크롤뷰로 수정
                ZStack(alignment: .topLeading) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.postColor)
                            .frame(height: 300)

                        ScrollView {
                            Text(item.text)
                                .foregroundStyle(.black)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(height: 300)
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
                        deleteAlert = true
                    }
                    .padding()
//                    .background(Color.clear)
                    .foregroundStyle(.gray)
                }
                
                Divider()
                
                // 댓글
                VStack(alignment: .leading, spacing: 8) {
                    Text("댓글")
                        .font(.headline)
                    
                    ScrollView {
                        VStack(spacing: 8) {
                            ForEach(commentsForItem) { comment in
                                HStack {
                                    Text(comment.text)
                                        .foregroundColor(.primary)
                                    
                                    Spacer()
                                    
                                    Button("수정") {
                                        newCommentText = comment.text
                                        editingComment = comment
                                    }
                                    .font(.caption)
                                    
                                    Button("삭제") {
                                        modelContext.delete(comment)
                                    }
                                    .foregroundColor(.red)
                                    .font(.caption)
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .frame(maxHeight: 100)
                }
                
                // 댓글 입력창
                HStack {
                    TextField("댓글을 입력하세요", text: $newCommentText)
                        .textFieldStyle(.roundedBorder)
                    
                    Button(editingComment == nil ? "확인" : "수정완료") {
                        if let editing = editingComment {
                            editing.text = newCommentText
                            editingComment = nil
                        } else {
                            let newComment = Comment(text: newCommentText, item: item)
                            modelContext.insert(newComment)
                        }
                        newCommentText = ""
                    }
                    .disabled(newCommentText.isEmpty)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("부잇 - 상세글보기")
            .navigationDestination(isPresented: $isNavigationToPostingView) {
                PostingView(editingItem: item)
            }
            .alert("정말 삭제하시겠습니까?", isPresented: $deleteAlert) {
                Button("삭제", role: .destructive) {
                    modelContext.delete(item)
                    dismiss()
                }
                Button("취소", role: .cancel) { }
            }
        }
    }
    
}


// 댓글



