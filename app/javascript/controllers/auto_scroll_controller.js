import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="auto-scroll"
export default class extends Controller {
  connect() {
    // console.log("Test connection");
    this.element.scrollIntoView({ behavior: "smooth", block: "start" });
  }
}
