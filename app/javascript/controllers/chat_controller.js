import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["loading", "responses"]

  submitQuery(event) {
    const queryInput = event.target.querySelector("input[name='chat[query]']").value;
    if (queryInput) {
      const queryHtml = `
        <div class="chat-response mb-3 d-flex flex-column">
          <div class="query-response-container">
            <p class="query alert alert-secondary text-end"><strong>Your Query:</strong> ${queryInput}</p>
          </div>
        </div>
      `;
      this.responsesTarget.insertAdjacentHTML('beforeend', queryHtml);
    }
    this.loadingTarget.style.display = "block"; // Show the loading spinner
  }

  hideLoading(event) {
    this.loadingTarget.style.display = "none"; // Hide the loading spinner
  }
}
