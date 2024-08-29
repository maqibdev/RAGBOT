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

    // Get the query content from the form
    const formData = new FormData(this.formTarget)
    const query = formData.get("research_paper[query]")

    // Display the user's query immediately and store the query element
    const queryElement = this.displayQuery(query)

    const url = this.formTarget.action

    fetch(url, {
      method: "POST",
      headers: { "Accept": "text/vnd.turbo-stream.html" },
      body: formData
    })
      .then(response => response.text())
      .then(html => {
        this.appendResponseToQuery(queryElement, html)
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
      <div class="chat-response mb-3 d-flex flex-column">
        <div class="query-response-container">
          <p class="query alert alert-secondary text-end"><strong>Your Query:</strong> ${query}</p>
          <div class="response-placeholder"></div>
        </div>
      </div>
    `
    this.responsesTarget.insertAdjacentHTML('beforeend', queryHtml)
    return this.responsesTarget.lastElementChild.querySelector('.response-placeholder')
  }

  appendResponseToQuery(queryElement, responseHtml) {
    // Insert the response HTML inside the response-placeholder
    queryElement.innerHTML = responseHtml
  }

  enableSubmitButton() {
    const submitButton = this.formTarget.querySelector("input[type=submit]")
    if (submitButton) {
      submitButton.disabled = false
    }
  }
}
