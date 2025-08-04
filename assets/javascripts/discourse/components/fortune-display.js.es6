import Component from "@ember/component";
import { ajax } from "discourse/lib/ajax";

export default Component.extend({
  fortune: null,

  init() {
    this._super(...arguments);
    this.loadExisting();
  },

  loadExisting() {
    ajax("/fortune_gpt/fortune").then((result) => {
      if (result.errors) {
        // eslint-disable-next-line no-console
        console.error(result.errors[0].message);
        return;
      }

      if (result.data) {
        this.set("fortune", result.data.text);
      }
    });
  },

  actions: {
    pickFortune() {
      ajax("/fortune_gpt/fortune", { method: "POST" })
        .then((result) => {
          if (result.errors) {
            // eslint-disable-next-line no-console
            console.error(result.errors[0].message);
            return;
          }

          this.set("fortune", result.data.text);
        })
        .catch((error) => {
          if (error && error.jqXHR && error.jqXHR.status === 409) {
            this.loadExisting();
          }
        });
    },
  },
});
