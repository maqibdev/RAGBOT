import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "responses", "loading", "submit", "query"]

  connect() {
    console.log("Chat controller connected")
  }

  submit(event) {
    event.preventDefault()

    // Show loading spinner
    this.loadingTarget.style.display = "block"

    // Display the user's query immediately
    const formData = new FormData(this.formTarget)
    const query = formData.get("research_paper[query]")
    this.displayQuery(query)

    const url = this.formTarget.action

    fetch(url, {
      method: "POST",
      headers: { "Accept": "text/vnd.turbo-stream.html" },
      body: formData
    })
      .then(response => response.text())
      .then(html => {
        this.responsesTarget.insertAdjacentHTML('beforeend', html)
        this.formTarget.reset()
        this.loadingTarget.style.display = "none"
        this.enableSubmitButton() // Re-enable the submit button
        this.formTarget.scrollIntoView({ behavior: "smooth" })
      })
      .catch(error => {
        console.error("Error:", error)
        this.loadingTarget.style.display = "none"
        this.enableSubmitButton() // Re-enable the submit button in case of error
        alert("Something went wrong. Please try again.")
      })
  }

  displayQuery(query) {
    const queryHtml = `
      <div class="alert alert-secondary mt-3">
        <strong>Your Query:</strong> ${query}
      </div>
    `
    this.responsesTarget.insertAdjacentHTML('beforeend', queryHtml)
  }

  enableSubmitButton() {
    const submitButton = this.formTarget.querySelector("input[type=submit]")
    if (submitButton) {
      submitButton.disabled = false
    }
  }
}
