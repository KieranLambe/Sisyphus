import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="remove-interest"
export default class extends Controller {
  static targets = ["interestGroup", "task", "interest"]

  getTasks() {
    const hidden_tasks = []
    const interest_groups = this.interestGroupTargets
    interest_groups.forEach(interest_group => {
      const tasks = interest_group.querySelectorAll(".task-card")
      tasks.forEach(task => {
        if(task.classList.contains("d-none")) {
          hidden_tasks.push(task)
        }
      })
      if(tasks.length === hidden_tasks.length) {
        this.interestTarget.classList.add("d-none")
      }
    })
  }
}
