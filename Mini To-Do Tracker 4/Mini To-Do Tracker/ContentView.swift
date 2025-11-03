//
//  ContentView.swift
//  Mini To-Do Tracker
//
//  Created by Lehman Student on 10/27/25.
//

import SwiftUI

struct ContentView: View {
    @State var tasks: [String] = [];
    @State var newTask : String = "";
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            Text("Your tasks:")
                .padding(5)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            List{
                ForEach(tasks.reversed(), id: \.self) { task in
                    VStack {
                        Text("-\(task)")
                    }
                    .padding(5)
                    .background(Color.gray)
                    .cornerRadius(10)
                    
                    
                }
            }
            .id(tasks.count)
            .animation(.spring, value: tasks)
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertMessage))
            }
            
            Text("Characters: \(newTask.count)/50")
                .font(.caption)
                .foregroundColor(newTask.count > 50 ? .red : .gray)
                .padding(.bottom, 10)
                .listRowInsets(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
            HStack {

                TextField("Add a new task", text: $newTask)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Add") {
                    let trimmedTask = newTask.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                    if (!tasks.contains(trimmedTask)) {
                        withAnimation(.spring()) {
                            tasks.append(trimmedTask);
                            newTask = "";
                        }
                    }
                    else{
                        alertMessage = "Tasks already exsits!";
                        showAlert = true;
                    }
                }
                .disabled(newTask.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || newTask.count > 50);


                }
            }
            
        .padding(.horizontal)
        }
    }




#Preview {
    ContentView()
}
