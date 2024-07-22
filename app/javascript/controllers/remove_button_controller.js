import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="remove-button"
export default class extends Controller {
  static targets = ["card", "form"];

  remove() {
    const url = this.formTarget.action;
    // console.log(url)
    const csrfToken = document.querySelector("[name='csrf-token']").content;
    // const
    this.cardTarget.classList.add("d-none")
    console.log(this.cardTarget.classList)

    fetch(url, {
    method: "DELETE",
    mode: "cors",
    cache: "no-cache",
    credentials: "same-origin",
    headers: {"Content-Type": "application/json", "X-CSRF-Token": csrfToken},
    })
      // .then((response) => response.json())
    //   .then((data) => console.log(data))
  }
}
