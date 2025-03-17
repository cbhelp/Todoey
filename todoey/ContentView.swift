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
    @State private var title: String = ""
    @State private var showingSheet = false
    @State private var backgroundColor: Color = .yellow
    var body: some View {
        ZStack{
//            LinearGradient(gradient: Gradient(colors: [.gray, .black]), startPoint: .leading, endPoint: .trailing)
//                .ignoresSafeArea()
            
            Color.black.ignoresSafeArea()
            VStack(alignment: .leading){
                HStack{
                    TextField("Title", text: $title, prompt: Text("New Note").foregroundColor(backgroundColor))
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(backgroundColor)//.white)
                    Button{
                        showingSheet.toggle()
                    }label:{
                        Image(systemName: "i.circle.fill")
                            .foregroundColor(backgroundColor)
                    }
                    .sheet(isPresented: $showingSheet){
                        SheetView(pickedColor: $backgroundColor, pickedTitle: $title)
                    }
                }
                List {
                    ForEach($todos) { $todo in
                        itemView(todo: $todo)
                            .foregroundColor(backgroundColor)
                    }
                    .onDelete { offsets in
                        todos.remove(atOffsets: offsets)
                    }
                }
                .scrollContentBackground(.hidden)
                Button{
                    todos.append(Todo(item: "", isDone: false))
                }label:{
                    HStack{
                        Image(systemName: "plus.circle.fill")
                        Text("New Reminder")
                    }
                    .font(.title)
                    .foregroundColor(backgroundColor)//.white)
                }
            }
            .padding()
        }
    }
}

struct itemView: View {
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
}

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var pickedColor: Color
    @Binding var pickedTitle: String
    let colors: [Color] = [.red, .blue, .green, .yellow, .purple, .pink, .brown]
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            VStack{
                Text("Pick A Color")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(pickedColor)
                HStack{
                    TextField("Title:", text: $pickedTitle)
                    Image(systemName: "list.bullet.circle.fill")
                }
                .padding()
                .font(.title)
                .bold()
                .foregroundColor(pickedColor)
                HStack{
                    ForEach(colors, id: \.self){color in
                        Button{
                            pickedColor = color
                        }label:{
                            Image(systemName: "list.bullet.circle.fill").resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(color)
                        }
                    }
                }
                .padding()
                Button{
                    dismiss()
                }label:{
                    HStack{
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(pickedColor)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
