import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="complete-button"
export default class extends Controller {
  static targets = ["button", "form"]

  connect() {
    console.log("Hello")
    console.log(this.buttonTarget)
    // this.buttonTarget.value = false
    this.buttonTarget.setAttribute("data-id", "incomplete")
  }

  // completeButton() {
  //   let status = this.buttonTarget.getAttribute("data-id")
  //   if(status === "incomplete") {
  //     this.buttonTarget.setAttribute("data-id", "complete")
  //   }
  //   else {
  //     this.buttonTarget.setAttribute("data-id", "incomplete")
  //   }
  //   console.log(status)
  //   this.buttonTarget.submit()
    // console.log(this.buttonTarget.value)
    // if(this.buttonTarget.value === false) {
    //   this.buttonTarget.value = true
    // }
    // else {
    //   this.buttonTarget.value = false
    // }
  // }

  completeButton(event) {
    event.preventDefault()
    const url = this.formTarget.action
    fetch(url, {
      method: "PATCH",
      headers: { "Accept": "text/plain" },
      body: new FormData(this.formTarget)
    })
      .then(response => response.text())
      .then((data) => {
        console.log(data)
      })
  }
}
