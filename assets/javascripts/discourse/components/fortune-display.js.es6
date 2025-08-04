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
      if (result.data) {
        this.set("fortune", result.data.text);
      }
    });
  },

  actions: {
    pickFortune() {
      ajax("/fortune_gpt/fortune", { method: "POST" })
        .then((result) => {
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
