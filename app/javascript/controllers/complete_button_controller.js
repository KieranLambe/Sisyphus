import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="complete-button"
export default class extends Controller {
  static targets = ["form", "button"]

  connect() {
    console.log("Hello")
    console.log(this.formTarget)
    console.log(this.buttonTarget.checked)
    // console.log(document.getElementById("user_task_complete").checked)
    // this.buttonTarget.value = false
    // this.buttonTarget.setAttribute("data-id", "incomplete")
  }

  completeButton(event) {
    console.log(this.buttonTarget.complete)
    if(this.buttonTarget.checked) {
      this.buttonTarget.value = true
    }
    else {
      this.buttonTarget.value = false
    }
    // let status = new FormData()
    // status.append("user_task[complete]", this.buttonTarget.checked);
    // fetch(this.data.get("update-url"), {
    //   body: formData,
    //   method: 'PATCH',
    //   credentials: "include",
    //   dataType: "script",
    //   headers: {
    //           "X-CSRF-Token": getMetaValue("csrf-token")
    //    },
    // // console.log(status)
    // // this.buttonTarget.submit()
    // // console.log(this.buttonTarget.value)
    // // if(this.buttonTarget.value === false) {
    // //   this.buttonTarget.value = true
    // // }
    // // else {
    // //   this.buttonTarget.value = false
    // }).then(function(response) {
    //   if (response.status != 204) {
    //     event.target.complete = !event.target.complete
    //   }
    // }).then((data) => {
    //   console.log(data)
    // })
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

//   completeButton(event) {

// }
