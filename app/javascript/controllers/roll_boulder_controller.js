import { Controller } from "@hotwired/stimulus";

let checked_array = []

export default class extends Controller {
  static targets = ["boulder", "hill", ];

  initialize() {
    console.log(this.boulderTarget);
    console.log(this.hillTarget);
  }

  rollBoulder() {
    const hillWidth = this.hillTarget.offsetWidth;
    const hillHeight = this.hillTarget.offsetHeight;
    const boulderWidth = this.boulderTarget.offsetWidth;
    const boulderHeight = this.boulderTarget.offsetHeight;
    const newPositionX = hillWidth - boulderWidth;
    const newPositionY = hillHeight - boulderHeight;
    var forms = document.querySelectorAll(".button-container");
    var forms_array = [...forms];
    const list_length = forms_array.length

    forms_array.forEach(form => {
      if(form.children[0].children[3].checked) {
        checked_array.push(form)
      }
    });
    this.currentStage = checked_array.length;
    console.log(this.currentStage)

    this.boulderTarget.classList.add("transition-effect");

    if (this.currentStage === 0) {
      // Move the this.boulderTarget to the top right
      const firstPositionX = (newPositionX / list_length) * checked_array.length;
      const firstPositionY = (newPositionY / list_length) * checked_array.length;
      this.boulderTarget.style.transform = `translate(${firstPositionX}px, -${firstPositionY}px) rotate(360deg)`;
      // this.currentStage++;
    } else if (this.currentStage === 1) {
      const secondPositionX = (newPositionX / list_length) * checked_array.length;
      const secondPositionY = (newPositionY / list_length) * checked_array.length;
      this.boulderTarget.style.transform = `translate(${secondPositionX}px, -${secondPositionY}px) rotate(720deg)`;
      // this.currentStage++;
    } else if (this.currentStage === 2) {
      const thirdPositionX = (newPositionX / list_length) * checked_array.length;
      const thirdPositionY = (newPositionY / list_length) * checked_array.length;
      this.boulderTarget.style.transform = `translate(${thirdPositionX}px, -${thirdPositionY}px) rotate(1080deg)`;
      // this.currentStage++;
    } else if (this.currentStage === 3) {
      const fourthPositionX = (newPositionX / list_length) * checked_array.length;
      const fourthPositionY = (newPositionY / list_length) * checked_array.length;
      this.boulderTarget.style.transform = `translate(${fourthPositionX}px, -${fourthPositionY}px) rotate(1440deg)`;
      // this.currentStage++;
    } else {
      this.boulderTarget.style.transform = `translate(${newPositionX}px, -${newPositionY}px) rotate(1800deg)`;
    }
  }

  completeTask() {

  }
}
