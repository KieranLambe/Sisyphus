import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="complete-button"
export default class extends Controller {
  static targets = ["button", "form"]

  connect() {
    // const url = this.formTarget.action
    // if(this.buttonTarget)
    // console.log("Hello")
    // console.log(this.buttonTarget)
    // console.log(this.buttonTarget.checked)
    // console.log(document.getElementById("user_task_complete").checked)
    // this.buttonTarget.value = false
    // this.buttonTarget.setAttribute("data-id", "incomplete")
    // fetch(url)
    // .then((response) => response.json())
    // .then((data) => {
    //   console.log(data)
    // })
  }

  tick(e) {
    const id = e.target.dataset.id;
    const userId = e.target.dataset.userId;
    const url = this.formTarget.action;
    const csrfToken = document.querySelector("[name='csrf-token']").content;
    // console.log(this.buttonTarget.checked)
    // console.log(this.buttonTarget.action)
    // if(this.buttonTarget.checked) {
    //   this.buttonTarget.value = true
    // }
    // else {
    //   this.buttonTarget.value = false
    // }

    // const options =
    // console.log(options.body)

    fetch(url, {
    method: "PATCH",
    mode: "cors",
    cache: "no-cache",
    credentials: "same-origin",
    headers: {"Content-Type": "application/json", "X-CSRF-Token": csrfToken},
    body: JSON.stringify({"user_task": { complete: this.buttonTarget.checked } }),
    })
      .then((response) => response.json())
      .then((data) => {
        console.log(data);
      });
  }
}

//   completeButton(event) {
