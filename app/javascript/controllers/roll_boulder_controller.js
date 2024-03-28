import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["boulder", "hill", ];

  initialize() {
    var forms = document.querySelectorAll(".button-container");
    var forms_array = [...forms];
    forms_array.forEach(form =>
      console.log(form.children.checked)
    );
    this.currentStage = 0;
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

    this.boulderTarget.classList.add("transition-effect");

    if (this.currentStage === 0) {
      // Move the this.boulderTarget to the top right
      const firstPositionX = newPositionX / 5;
      const firstPositionY = newPositionY / 5;
      this.boulderTarget.style.transform = `translate(${firstPositionX}px, -${firstPositionY}px) rotate(360deg)`;
      this.currentStage++;
    } else if (this.currentStage === 1) {
      const secondPositionX = (newPositionX / 5) * 2;
      const secondPositionY = (newPositionY / 5) * 2;
      this.boulderTarget.style.transform = `translate(${secondPositionX}px, -${secondPositionY}px) rotate(720deg)`;
      this.currentStage++;
    } else if (this.currentStage === 2) {
      const thirdPositionX = (newPositionX / 5) * 3;
      const thirdPositionY = (newPositionY / 5) * 3;
      this.boulderTarget.style.transform = `translate(${thirdPositionX}px, -${thirdPositionY}px) rotate(1080deg)`;
      this.currentStage++;
    } else if (this.currentStage === 3) {
      const fourthPositionX = (newPositionX / 5) * 4;
      const fourthPositionY = (newPositionY / 5) * 4;
      this.boulderTarget.style.transform = `translate(${fourthPositionX}px, -${fourthPositionY}px) rotate(1440deg)`;
      this.currentStage++;
    } else {
      this.boulderTarget.style.transform = `translate(${newPositionX}px, -${newPositionY}px) rotate(1800deg)`;
    }
  }

  completeTask() {

  }
}
