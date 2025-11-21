import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2"

export default class extends Controller {
  openPrompt() {
    Swal.fire({
      title: "Create a New Persona",
      input: "text",
      inputPlaceholder: "e.g. Albert Einstein",
      showCancelButton: true,
      confirmButtonText: "Create"
    }).then(result => {
      if (result.isConfirmed) {
        const name = result.value.trim()
        if (name.length > 0) {
          this.createPersona(name)
        }
      }
    })
  }

  createPersona(name) {
    fetch("/personas", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
      },
      body: JSON.stringify({
        persona: { name: name }
      })
    })
    .then(response => response.json())
    .then(data => {
      if (data.redirect_url) {
        window.location.href = data.redirect_url
      } else {
        Swal.fire("Error", "Could not create persona.", "error")
      }
    })
  }
}
