import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="complete-button"
export default class extends Controller {
  static targets = ["form"]

  connect() {
    // console.log("Hello")
    console.log(this.formTarget)
    // console.log(this.buttonTarget.checked)
    // console.log(document.getElementById("user_task_complete").checked)
    // this.buttonTarget.value = false
    // this.buttonTarget.setAttribute("data-id", "incomplete")
  }

  completeButton(event) {
    event.preventDefault()
    const url = this.formTarget.action
    // console.log(this.buttonTarget.checked)
    // console.log(this.buttonTarget.action)
    // if(this.buttonTarget.checked) {
    //   this.buttonTarget.value = true
    // }
    // else {
    //   this.buttonTarget.value = false
    // }

    const options = {method: "PATCH",
    headers: {"Content-Type": "text/plain"},
    body: JSON.stringify({"complete": this.buttonTarget.value})}
    console.log(options.headers)

    // fetch(url,
    //   options
    // )
    //   .then(response => response.json())
    //   .then((data) => {
    //     console.log(data)
    //     console.log(response)
    //   })
  }
}

//   completeButton(event) {
