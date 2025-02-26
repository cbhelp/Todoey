//
//  ContentView.swift
//  todoey
//
//  Created by Canon Helpman on 2/25/25.
//
import SwiftUI

struct Todo: Identifiable {
    var id = UUID()
    var item: String
    var isDone: Bool
}

struct ContentView: View {
    // Replace with todos @State private vars
    @State private var todos: [Todo] = []
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.purple, .pink]), startPoint: .leading, endPoint: .trailing)
                .ignoresSafeArea()
            VStack(alignment: .leading){
                Text("Todo List:")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                List {
                    ForEach($todos) { $todo in
                        //itemView(todo: $todo)
                        HStack{
                            Button{
                                todo.isDone = !todo.isDone
                            } label:{
                                Image(systemName: todo.isDone ? "checkmark.circle.fill" : "circle")
                            }
                            TextField("Task:" , text: $todo.item)
                        }
                    }
                }
                .listRowBackground(Color.clear)
                .scrollContentBackground(.hidden)
                Button{
                    todos.append(Todo(item: "", isDone: false))
                }label:{
                    HStack{
                        Image(systemName: "plus.circle.fill")
                        Text("New Reminder")
                    }
                    .font(.title)
                    .foregroundColor(.white)
                }
            }
            .padding()
        }
    }
}

/*struct itemView: View {
    @Binding var todo: Todo
    var body: some View {
        HStack{
            Button{
                todo.isDone = !todo.isDone
            } label:{
                Image(systemName: todo.isDone ? "checkmark.circle.fill" : "circle")
                
            }
            TextField("Task:", text: $todo.item)
        }
    }
}*/

#Preview {
    ContentView()
}
