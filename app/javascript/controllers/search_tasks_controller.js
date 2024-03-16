import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-tasks"
export default class extends Controller {
  static targets = ["form", "query", "list"];

  connect() {
    console.log(this.listTarget)
  }

  search(event) {
    // event.preventDefault();
    // console.log(this.queryTarget.value);
    console.log(this.queryTarget.value);
    console.log(this.formTarget.action);
    console.log(this.listTarget);
    if (event.key === "Backspace" && !this.queryTarget.value.trim()) {
      event.preventDefault();
      return;
    }
    const url = `${this.formTarget.action}?query=${this.queryTarget.value}`

    fetch(url, {headers: {"Accept": "text/plain"}})
      .then(response => response.text())
      .then((data) => {
        // console.log(data);
        this.listTarget.outerHTML = data;
      })
  }
}
