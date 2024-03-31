import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="complete-button"
export default class extends Controller {
  static targets = ["button", "form"]

  tick(e) {
    const url = this.formTarget.action;
    const csrfToken = document.querySelector("[name='csrf-token']").content;

    fetch(url, {
    method: "PATCH",
    mode: "cors",
    cache: "no-cache",
    credentials: "same-origin",
    headers: {"Content-Type": "application/json", "X-CSRF-Token": csrfToken},
    body: JSON.stringify({"user_task": { complete: this.buttonTarget.checked } }),
    })
      .then((response) => response.json())
  }
}

//   completeButton(event) {
