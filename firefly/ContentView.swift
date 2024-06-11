//
//  ContentView.swift
//  firefly
//
//  Created by Rodrigo, Thenuk (Coll) on 11/06/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var newTodo: String = ""
    @State private var todos: [Todo] = []
    
    @State private var firebaseManager = FirebaseManager.shared
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    if todos.isEmpty {
                        Text("Add your first todo below")
                    }
                    else {
                        ForEach(todos, id: \.createdAt) { todo in
                            Text(todo.content)
                        }
                    }
                }
                .listStyle(.plain)
                Divider()
                
                
                TextField("enter a todo", text: $newTodo)
                    .onSubmit {
                        if newTodo.count > 0 {
                            firebaseManager.saveTodo(todo: newTodo)
                            newTodo = ""
                            firebaseManager.getTodos { todos, error in
                                if let error = error {
                                    print("error: \(error.localizedDescription)")
                                }
                                else {
                                    guard let todos = todos else {
                                        print("Something has gone wrong")
                                        return
                                    }
                                    self.todos = todos.sorted {
                                        $0.createdAt < $1.createdAt
                                    }
                                }
                            }
                        }
                    }
                
            }
            .padding()
            .navigationTitle("Firefly")
        }
        .onAppear {
            firebaseManager.getTodos { todos, error in
                if let error = error {
                    print("error: \(error.localizedDescription)")
                }
                else {
                    guard let todos = todos else {
                        print("Something has gone wrong")
                        return
                    }
                    self.todos = todos.sorted {
                        $0.createdAt < $1.createdAt
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
