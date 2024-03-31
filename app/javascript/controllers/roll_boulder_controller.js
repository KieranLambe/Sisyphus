import { Controller } from "@hotwired/stimulus";

var forms = forms = document.querySelectorAll(".button-container");
var forms_array = [...forms];

var checked_array;
let list_length;

// const hillWidth = this.hillTarget.offsetWidth;
// const hillHeight = this.hillTarget.offsetHeight;
// const boulderWidth = this.boulderTarget.offsetWidth;
// const boulderHeight = this.boulderTarget.offsetHeight;

export default class extends Controller {
  static targets = ["boulder", "hill", "remove", "form"];

  connect() {
    checked_array = [];
    const hillWidth = this.hillTarget.offsetWidth;
    const hillHeight = this.hillTarget.offsetHeight;
    const boulderWidth = this.boulderTarget.offsetWidth;
    const boulderHeight = this.boulderTarget.offsetHeight;
    const list_length = forms_array.length

    // this.setStages()
    this.currentStage = checked_array.length;
    const newPositionX = hillWidth - boulderWidth;
    const newPositionY = hillHeight - boulderHeight;

    this.getChecked()

    if (this.currentStage === 0) {
      // Move the this.boulderTarget to the top right
      const firstPositionX = (newPositionX / list_length) * checked_array.length;
      const firstPositionY = (newPositionY / list_length) * checked_array.length;
      return this.boulderTarget.style.transform = `translate(${firstPositionX}px, -${firstPositionY}px) rotate(360deg)`;
      // this.currentStage++;
    } else if (this.currentStage === 1) {
      const secondPositionX = (newPositionX / list_length) * checked_array.length;
      const secondPositionY = (newPositionY / list_length) * checked_array.length;
      return this.boulderTarget.style.transform = `translate(${secondPositionX}px, -${secondPositionY}px) rotate(720deg)`;
      // this.currentStage++;
    } else if (this.currentStage === 2) {
      const thirdPositionX = (newPositionX / list_length) * checked_array.length;
      const thirdPositionY = (newPositionY / list_length) * checked_array.length;
      return this.boulderTarget.style.transform = `translate(${thirdPositionX}px, -${thirdPositionY}px) rotate(1080deg)`;
      // this.currentStage++;
    } else if (this.currentStage === 3) {
      const fourthPositionX = (newPositionX / list_length) * checked_array.length;
      const fourthPositionY = (newPositionY / list_length) * checked_array.length;
      return this.boulderTarget.style.transform = `translate(${fourthPositionX}px, -${fourthPositionY}px) rotate(1440deg)`;
      // this.currentStage++;
    } else if (this.currentStage === 4) {
      const fourthPositionX = (newPositionX / list_length) * checked_array.length;
      const fourthPositionY = (newPositionY / list_length) * checked_array.length;
      return this.boulderTarget.style.transform = `translate(${fourthPositionX}px, -${fourthPositionY}px) rotate(1440deg)`;
    } else {
      return this.boulderTarget.style.transform = `translate(${newPositionX}px, -${newPositionY}px) rotate(1800deg)`;
    }
  }

  getChecked() {
    forms_array.forEach(form => {
      if(form.children[0].children[3].checked) {
        checked_array.push(form.children[0].children[3])
      }
    })
  }

  setStages() {
    list_length = forms_array.length
    return list_length
  }

  remove(e) {
    const url = this.formTarget.action;
    const csrfToken = document.querySelector("[name='csrf-token']").content;

    fetch(url, {
    method: "DELETE",
    mode: "cors",
    cache: "no-cache",
    credentials: "same-origin",
    headers: {"Content-Type": "application/json", "X-CSRF-Token": csrfToken},
    }).then((response) => response.json()).then((data) => console.log(data))
  }

  rollBoulder(e) {
    const button = e.target;
    const hillWidth = this.hillTarget.offsetWidth;
    const hillHeight = this.hillTarget.offsetHeight;
    const boulderWidth = this.boulderTarget.offsetWidth;
    const boulderHeight = this.boulderTarget.offsetHeight;
    // var forms = document.querySelectorAll(".button-container");
    // var forms_array = [...forms];

    this.setStages()

    // respond to check event, see if checked
    if(button.checked) {
      checked_array.push(button)
      this.currentStage = checked_array.length
      //
      // console.log(" hi")
    } else {
      // let index = forms_array.indexOf(button)
      // console.log(index)
      checked_array = checked_array.filter(function (input){
        return input !== button
      })
      this.currentStage = checked_array.length;
    }

    this.boulderTarget.classList.add("transition-effect");

    const newPositionX = hillWidth - boulderWidth;
    const newPositionY = hillHeight - boulderHeight;

    if (this.currentStage === 0) {
      // Move the this.boulderTarget to the top right
      const firstPositionX = (newPositionX / list_length) * checked_array.length;
      const firstPositionY = (newPositionY / list_length) * checked_array.length;
      return this.boulderTarget.style.transform = `translate(${firstPositionX}px, -${firstPositionY}px) rotate(360deg)`;
      // this.currentStage++;
    } else if (this.currentStage === 1) {
      const secondPositionX = (newPositionX / list_length) * checked_array.length;
      const secondPositionY = (newPositionY / list_length) * checked_array.length;
      return this.boulderTarget.style.transform = `translate(${secondPositionX}px, -${secondPositionY}px) rotate(720deg)`;
      // this.currentStage++;
    } else if (this.currentStage === 2) {
      const thirdPositionX = (newPositionX / list_length) * checked_array.length;
      const thirdPositionY = (newPositionY / list_length) * checked_array.length;
      return this.boulderTarget.style.transform = `translate(${thirdPositionX}px, -${thirdPositionY}px) rotate(1080deg)`;
      // this.currentStage++;
    } else if (this.currentStage === 3) {
      const fourthPositionX = (newPositionX / list_length) * checked_array.length;
      const fourthPositionY = (newPositionY / list_length) * checked_array.length;
      return this.boulderTarget.style.transform = `translate(${fourthPositionX}px, -${fourthPositionY}px) rotate(1440deg)`;
      // this.currentStage++;
    } else if (this.currentStage === 4) {
      const fourthPositionX = (newPositionX / list_length) * checked_array.length;
      const fourthPositionY = (newPositionY / list_length) * checked_array.length;
      return this.boulderTarget.style.transform = `translate(${fourthPositionX}px, -${fourthPositionY}px) rotate(1440deg)`;
    } else {
      return this.boulderTarget.style.transform = `translate(${newPositionX}px, -${newPositionY}px) rotate(1800deg)`;
    } }
}
