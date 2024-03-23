import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="complete-button"
export default class extends Controller {
  static targets = ["button"]

  connect() {
  }

  complete_button() {
    console.log("Hello")
  }
}
