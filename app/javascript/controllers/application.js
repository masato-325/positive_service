// app/javascript/controllers/application.js
import { Application } from "@hotwired/stimulus"
import SearchController from "./search_controller"

const application = Application.start()
application.register("search", SearchController)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
